| **日本語** | [English](/modules/alb/README.md) |
| --- | --- |

## alb
パブリックサブネット内にインターネットからアプリケーションに接続するためのアプリケーションロードバランサー(ALB)を作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|vpc_id|string|VPCのID|
|public_subnet_ids|list(string)|パブリックサブネットのIDのリスト|
|app_sg_id|string|アプリケーション(ECS Fargate)に設定したセキュリティグループのID。ALBからアプリケーションへの通信を許可するために使用する。|
|target_port|number|アプリケーションとの通信ポート|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|sg_target_protocol|string|tcp|セキュリティグループの、アプリケーションとの通信プロトコル|
|target_protocol|string|HTTP|アプリケーションとの通信プロトコル|
|health_check_path|string|/|アプリケーションのヘルスチェック用のパス|
|healthy_threshold|number|5|ヘルスチェックが成功とみなされる連続成功回数|
|unhealthy_threshold|number|5|ヘルスチェックが失敗とみなされる連続失敗回数|
|timeout|number|10|ヘルスチェックがタイムアウトとみなされる秒数|
|interval|number|30|ヘルスチェックの間隔(秒)|
|matcher|string|200|ヘルスチェックが成功とみなされるステータスコード|
|health_check_port|string|traffic-port|ヘルスチェックに使われるポート|
|health_check_protocol|string|HTTP|ヘルスチェックに使われる通信プロトコル|

### アウトプット
|変数名|説明|
|---|---|
|alb_dns_name|ALBのDNS名|
|target_group_arn|ターゲットグループのARN|
|alb_sg_id|ALBに設定したセキュリティグループのID|

### 補足
- `env` が `dev` のときのみHTTPのリスナーが作成される。  
開発環境以外ではHTTPSリスナーのみを用いて外部と通信する。  
※ HTTPSリスナーの定義はコメントアウトされています。使用する際は、AWS Certificate Manager(ACM)で証明書を発行し、モジュールの調整をする必要があります。