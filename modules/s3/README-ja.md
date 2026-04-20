| **日本語** | [English](/modules/s3/README.md) |
| --- | --- |

## s3
S3のバケットを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|account_id|string|AWSアカウントのID|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|storage_name|string|ストレージ名。バケット名は `<AWSのアカウントのID>-<プロジェクト名>-<環境>-<ストレージ名>` になる。|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|is_private_access|bool|true|プライベートアクセスかどうか|
|is_versioning|bool|false|バケットをバージョン管理するかどうか|