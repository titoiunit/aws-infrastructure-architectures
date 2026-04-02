import json
import os
import uuid
from datetime import datetime, timezone

import boto3

TABLE_NAME = os.environ["TABLE_NAME"]

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)


def response(status_code, payload):
    return {
        "statusCode": status_code,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps(payload)
    }


def handler(event, context):
    method = event.get("requestContext", {}).get("http", {}).get("method", "")
    path = event.get("rawPath", "")

    if method == "GET" and path == "/health":
        return response(200, {"status": "ok"})

    if method == "GET" and path == "/items":
        result = table.scan(Limit=50)
        items = result.get("Items", [])
        items.sort(key=lambda item: item.get("created_at", ""))
        return response(200, {"items": items})

    if method == "POST" and path == "/items":
        raw_body = event.get("body") or "{}"

        try:
            body = json.loads(raw_body)
        except json.JSONDecodeError:
            return response(400, {"message": "Request body must be valid JSON."})

        name = body.get("name")
        if not name:
            return response(400, {"message": "Field 'name' is required."})

        item_id = body.get("id") or str(uuid.uuid4())

        item = {
            "id": item_id,
            "name": name,
            "created_at": datetime.now(timezone.utc).isoformat()
        }

        table.put_item(Item=item)

        return response(201, {
            "message": "Item created.",
            "item": item
        })

    return response(404, {"message": "Not found."})
