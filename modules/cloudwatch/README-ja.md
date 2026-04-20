| **日本語** | [English](/modules/cloudwatch/README.md) |
| --- | --- |

## cloudwatch
CloudWatch Logsのロググループを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|log_group_name|string|ロググループ名。実際には `<プロジェクト名>-<環境>-<ロググループ名>` という名前になる。|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|log_retention_days|number|30|ログの保存期間(日)|

### アウトプット
|変数名|説明|
|---|---|
|log_group_name|ロググループ名(プロジェクト名や環境を含めた名前)|