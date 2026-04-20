| **日本語** | [English](/modules/ecr/README.md) |
| --- | --- |

## ecr
ECRのプライベートリポジトリを作成するモジュールです。

### 必須の変数
|変数名|型|説明|
|---|---|---|
|app_name|string|プロジェクト名|
|env|string|環境(loc, dev, stg, prod)|
|image_name|string|リポジトリで管理するDockerイメージ名|

### オプション変数
|変数名|型|デフォルト値|説明|
|---|---|---|---|
|common_tags|map(string)|{}|共通タグのマップ|
|ecr_max_image_count|number|10|リポジトリで管理する最大イメージ数(古い順に削除される)|

### アウトプット
|変数名|説明|
|---|---|
|repository_url|リポジトリのURL|