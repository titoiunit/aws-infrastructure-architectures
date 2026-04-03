import json
import os
from datetime import datetime, timezone
from urllib.parse import unquote_plus

import boto3

s3 = boto3.client("s3")
sqs = boto3.client("sqs")

BUCKET_NAME = os.environ["BUCKET_NAME"]
QUEUE_URL = os.environ["QUEUE_URL"]
UPLOAD_PREFIX = os.environ["UPLOAD_PREFIX"]
PROCESSED_PREFIX = os.environ["PROCESSED_PREFIX"]


def build_result(source_bucket, source_key, text_content):
    lines = text_content.splitlines()
    words = text_content.split()

    result_key = f"{PROCESSED_PREFIX}{source_key[len(UPLOAD_PREFIX):]}.json"

    return {
        "source_bucket": source_bucket,
        "source_key": source_key,
        "processed_bucket": source_bucket,
        "processed_key": result_key,
        "processed_at": datetime.now(timezone.utc).isoformat(),
        "file_type": "text",
        "line_count": len(lines),
        "word_count": len(words),
        "character_count": len(text_content),
    }


def handler(event, context):
    print(json.dumps({
        "message": "Lambda invoked",
        "event": event
    }))

    records = event.get("Records", [])
    processed_results = []

    for record in records:
        source_bucket = record["s3"]["bucket"]["name"]
        source_key = unquote_plus(record["s3"]["object"]["key"])

        if not source_key.startswith(UPLOAD_PREFIX):
            print(json.dumps({
                "message": "Skipping object because prefix does not match",
                "source_key": source_key
            }))
            continue

        response = s3.get_object(Bucket=source_bucket, Key=source_key)
        file_bytes = response["Body"].read()
        text_content = file_bytes.decode("utf-8", errors="replace")

        result = build_result(source_bucket, source_key, text_content)

        s3.put_object(
            Bucket=source_bucket,
            Key=result["processed_key"],
            Body=json.dumps(result, indent=2).encode("utf-8"),
            ContentType="application/json"
        )

        sqs.send_message(
            QueueUrl=QUEUE_URL,
            MessageBody=json.dumps({
                "event_type": "file_processed",
                "source_bucket": result["source_bucket"],
                "source_key": result["source_key"],
                "processed_bucket": result["processed_bucket"],
                "processed_key": result["processed_key"],
                "processed_at": result["processed_at"]
            })
        )

        print(json.dumps({
            "message": "File processed successfully",
            "result": result
        }))

        processed_results.append(result)

    return {
        "statusCode": 200,
        "body": json.dumps({
            "processed_count": len(processed_results),
            "results": processed_results
        })
    }
