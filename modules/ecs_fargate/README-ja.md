| **日本語** | [English](/modules/ecs_fargate/README.md) |
| --- | --- |

## ecs_fargate
プライベートサブネット内にアプリケーションロードバランサー(ALB)を介してインターネットと接続するECS Fargateサービス(アプリケーション)を作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|account_id|string|AWSアカウントのID|
|region|string|AWSのリージョン(例: ap-northeast-1)|
|app_name|string|プロジェクト名|
|env|string|環境(dev, stg, prod)|
|vpc_id|string|VPCのID|
|private_subnet_ids|list(string)|プライベートサブネットのIDのリスト|
|alb_sg_id|string|ALBに設定したセキュリティグループのID。ALBからECSへの通信を許可するために使用する。|
|endpoint_sg_id|string|null|VPCエンドポイントに設定したセキュリティグループのID。ECSからVPCエンドポイントへの通信を許可するために使用する。`is_endpoint` を `false` にする場合は `null` を指定する。|
|container_definitions|list(any)|ECSタスクのコンテナ定義のリスト|
|task_definition_file_path|string|タスク定義のJSONファイルを出力するパス。GitHub Actionsなどで使用する想定。|
|target_group_arn|string|ターゲットグループのARN|
|target_container|string|ターゲットグループに含まれるコンテナ名|
|target_port|number|ターゲットグループに含まれるコンテナとの通信ポート|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|sg_target_protocol|string|tcp|セキュリティグループの、ALBとの通信プロトコル|
|is_endpoint|bool|true|VPCエンドポイントと通信するかどうか|
|is_cloud_watch_logs|bool|true|CloudWatch Logsにロググループを作成するかどうか|
|is_secrets_manager|bool|true|Secrets Managerからシークレットを取得するかどうか|
|custom_task_role_policy|string|null|ECSタスクロールにアタッチする、JSONエンコードされたポリシー(S3との通信など)|
|cpu|string|1024|タスクに割り当てるCPUユニット数(1vCPU = 1024)|
|memory|string|3072|タスクに割り当てるメモリ量(MiB)|
|desired_count|number|1|起動するタスクの数|

### アウトプット
|変数名|説明|
|---|---|
|ecs_sg_id|ECSに設定したセキュリティグループのID|