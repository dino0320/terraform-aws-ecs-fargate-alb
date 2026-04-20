| **日本語** | [English](/modules/vpc/README.md) |
| --- | --- |

## vpc
VPCやサブネット、VPCエンドポイント、NAT Gatewayなどを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|region|string|AWSのリージョン(例: ap-northeast-1)|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|availability_zones|list(string)|アベイラビリティゾーンのリスト(例: ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"])|
|vpc_cidr|string|VPCのCIDR(例: 172.32.0.0/16)|
|public_subnet_cidrs|list(string)|パブリックサブネットのCIDRのリスト(例: ["172.32.0.0/20",  "172.32.16.0/20", "172.32.32.0/20"])|
|private_subnet_cidrs|list(string)|プライベートサブネットのCIDRのリスト(例: ["172.32.48.0/20", "172.32.64.0/20", "172.32.80.0/20"])|
|app_sg_id|string|アプリケーションに設定したセキュリティグループのID。アプリケーションからVPCエンドポイントへの通信を許可するために使用する。|
|is_nat_gateway|bool|NAT Gatewayを作成するかどうか|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|interface_services|list(string)|[]|VPCエンドポイントのInterfaceのサービスのリスト(例: ["ecr.dkr", "ecr.api", "logs", "secretsmanager"])|
|gateway_services|list(string)|[]|VPCエンドポイントのGatewayのサービスのリスト(例: ["s3"])|

### アウトプット
|変数名|説明|
|---|---|
|vpc_id|VPCのID|
|public_subnet_ids|パブリックサブネットのIDのリスト|
|private_subnet_ids|プライベートサブネットのIDのリスト|
|endpoint_sg_id|VPCエンドポイントに設定したセキュリティグループのID|