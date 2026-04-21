| **日本語** | [English](/modules/rds/README.md) |
| --- | --- |

## rds
プライベートサブネット内にRDSインスタンスを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|app_name|string|プロジェクト名|
|env|string|環境(dev, stg, prod)|
|vpc_id|string|VPCのID|
|private_subnet_ids|list(string)|プライベートサブネットのIDのリスト|
|app_sg_id|string|アプリケーション(ECS Fargate)に設定したセキュリティグループのID。アプリケーションからRDSインスタンスへの通信を許可するために使用する。|
|engine|string|DBエンジン名(例: postgres)|
|engine_version|string|DBエンジンのバージョン(例: 17.6)|
|instance_class|string|インスタンスクラス名(例: db.m7g.large)|
|db_name|string|初期データベース名|
|db_port|number|RDSインスタンスとの通信ポート|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|sg_db_protocol|string|tcp|セキュリティグループの、アプリケーションとの通信プロトコル|
|password_length|number|16|パスワードの文字数|
|is_special|bool|true|記号などの特殊文字をパスワードに含めるかどうか|
|allocated_storage|number|20|最初に確保するディスク容量(GB)|
|max_allocated_storage|number|100|ディスク容量の自動拡張の上限値(GB)|
|storage_type|string|gp3|ディスクの種類|
|is_skip_final_snapshot|bool|false|DBインスタンス削除前の最終スナップショット作成をスキップするかどうか|
|is_deletion_protection|bool|true|DBインスタンスの削除保護を有効にするかどうか(誤削除防止)|
|db_username|string|dbadmin|初期ユーザー名|

### アウトプット
|変数名|説明|
|---|---|
|db_instance_address|RDSインスタンスのホスト名|
|db_password_secret_arn|DBパスワードを保存しているSecrets ManagerのシークレットのARN|

### 補足
- `skip_final_snapshot` は `env` の値が `dev` のとき `true` となり、それ以外の環境では `false` になる。  
インスタンスを削除するとき、開発環境以外ではスナップショットが残る。
- `deletion_protection` は `env` の値が `prod` のとき `true` となり、それ以外の環境では `false` になる。  
本番環境ではインスタンスを削除する前に手動で保護を解除する必要がある。