#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y python3 stress-ng

systemctl enable --now amazon-ssm-agent || true

mkdir -p /opt/rce51-web

cat > /opt/rce51-web/index.html <<'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>RCE-51 Auto Scaling Lab</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #0f172a;
      color: #e2e8f0;
      margin: 0;
      padding: 40px;
    }
    .card {
      max-width: 760px;
      margin: 0 auto;
      background: #111827;
      padding: 32px;
      border-radius: 16px;
    }
    code {
      background: #1f2937;
      padding: 2px 6px;
      border-radius: 6px;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>RCE-51 Auto Scaling Lab</h1>
    <p>This instance was launched by an Auto Scaling Group.</p>
    <p>Region: <code>eu-west-1</code></p>
    <p>Repo: <code>aws-infrastructure-architectures</code></p>
    <p>Use Session Manager to log in and run <code>stress-ng</code> for CPU load testing.</p>
  </div>
</body>
</html>
HTMLEOF

cat > /etc/systemd/system/rce51-web.service <<'SERVICEEOF'
[Unit]
Description=RCE-51 Simple Web Server
After=network.target

[Service]
Type=simple
WorkingDirectory=/opt/rce51-web
ExecStart=/usr/bin/python3 -m http.server 80 --directory /opt/rce51-web
Restart=always
User=root

[Install]
WantedBy=multi-user.target
SERVICEEOF

systemctl daemon-reload
systemctl enable rce51-web
systemctl start rce51-web
