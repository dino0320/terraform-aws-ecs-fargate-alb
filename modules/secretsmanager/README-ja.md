| **日本語** | [English](/modules/secretsmanager/README.md) |
| --- | --- |

## secretsmanager
Secrets Managerのシークレットを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|secrets_name|string|シークレット名。実際には `<プロジェクト名>-<環境>-<シークレット名>` という名前になる。|
|secret_values|string|JSONエンコードされたシークレットのキーと値のペア|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|recovery_window_in_days|number|0|削除されるまでの期間(日)|

### アウトプット
|変数名|説明|
|---|---|
|secret_arn|シークレットのARN|