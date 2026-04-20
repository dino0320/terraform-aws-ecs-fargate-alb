{
    "name": "web",
    "image": "${image_url}",
    "portMappings": [
        {
            "containerPort": ${port},
            "hostPort": ${port},
            "protocol": "tcp"
        }
    ],
    "essential": true,
    "environment": [
        {
            "name": "APP_ENV",
            "value": "${env}"
        }
    ],
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${log_group}",
            "awslogs-create-group": "true",
            "awslogs-region": "${region}",
            "awslogs-stream-prefix": "web"
        }
    }
}