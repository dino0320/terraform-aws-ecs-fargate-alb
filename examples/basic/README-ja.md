| **日本語** | [English](/examples/basic/README.md) |
| --- | --- |

## NGINXアプリケーションの例
NGINXのDockerイメージを使ったWebアプリケーションの作成例です。

### クイックスタート
#### 1. `dev.tfvars` を作成する。
`dev.tfvars.example` をコピーして `dev.tfvars` を作成します。  
`account_id` と `profile` を自分の環境に合わせて変更してください。

```tfvars
account_id = "123456789012"   # 自分のAWSアカウントのID
region     = "ap-northeast-1"
profile    = "my-profile"     # AWS SSOで作成したプロファイル名
```

その他の値も必要に応じて変更してください。

#### 2. ディレクトリを移動する。
`examples/basic` ディレクトリに移動します。

```bash
cd <リポジトリのリートディレクトリ>/examples/basic
```

#### 3. Terraformモジュールを初期化する。
以下を実行して外部モジュールやプロバイダーを初期化・更新します。

```bash
terraform init -upgrade
```

#### 4. 実行計画を確認し、構築する
まず `plan` で作成されるリソースを確認し、問題なければ `apply` で構築します。

```bash
# 実行計画の確認
terraform plan -var-file="dev.tfvars"

# 構築の実行
terraform apply -var-file="dev.tfvars"
```

#### 5. NGINXアプリケーションを確認する。
AWS管理コンソールから作成したアプリケーションロードバランサー(ALB)のDNSを取得し、ブラウザ等でNGINXアプリケーションを確認します。

```
http://<ALBのDNS>
```

#### 6. リソースの削除
試用が終わった後は、以下のコマンドで作成したリソースをすべて削除し、課金を停止します。

```bash
terraform destroy -var-file="dev.tfvars"
```