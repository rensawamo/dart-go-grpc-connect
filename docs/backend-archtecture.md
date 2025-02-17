
# Go バックエンドアーキテクチャ
概要

![Group 53](https://github.com/user-attachments/assets/213360f8-3e60-4796-b0f0-377b604a9a51)

Goのバックエンド クリーンアーキテクチャのプロジェクトです。
このプロジェクトでは、以下の技術を使用しています

- **Mux（HTTP ルーティング）**
- **MySQL(データベース）**
- **JWT 認証ミドルウェア**
- **Docker**
  

## アーキテクチャ構成
アプリケーションは以下の層で構成されています

- **Router (Mux)**
クライアントリクエストの適切なhandlerへのルーティング

- **Handler (Controller)**
リクエストの受付とUsecaseの呼び出し

- **Usecase**
ビジネスロジックの実装

- **Repository**
データベース操作の抽象化

- **Domain (Model/Entity)**
基本データ構造の定義

- **Dependency Injection (DI)**
依存関係の管理を行い、各レイヤーの疎結合化を実現


# プロジェクト構造
```sh
backend/
├── api/
│   ├── handler/       # Controllerレイヤー
│   ├── interceptor/   # gRPCインターセプター
├── cmd/               # エントリーポイント
├── database/          # データベース関連
├── di/                # 依存性注入（DI）
├── domain/            # ドメインモデル
├── gen/               # コード生成（protobufなど）
├── internal/          # 内部パッケージ
├── repository/        # リポジトリ実装
├── usecase/           # ユースケース実装
```

# リクエストフロー

## パブリックAPI
<img width="529" alt="image" src="https://github.com/user-attachments/assets/7d830f16-12e2-4338-b01b-b7ebb03aa732" />


## 認証付きAPI
<img width="516" alt="image" src="https://github.com/user-attachments/assets/2ce62a77-e7a0-4457-8b92-f86be4bc761d" />


# SET UP
### プロジェクト用の暗号鍵を作成
```sh
$ ssh-keygen -t rsa -b 2048 -f $PRIVATE_KEY_PATH -N ""
$ ssh-keygen -p -m PEM -f $PRIVATE_KEY_PATH
```

backend/.envrcの環境変数を変更する。
```sh
PRIVATE_KEY_PATH=YOURS
```

### backendに移動してdirenvを読み込む
```sh
$ cd backend && direnv allow
```

### DockerのMySqlを立ち上げる
```sh
$ make up
```

### マイグレーションアップ
※ 同じくディレクトリ環境変数を読み込み
ユーザーと、elizaが返す文章を登録しておきます。
```sh
$ make migrate-up
```

### テストユーザの登録

| id   | email             | password | created_at          | updated_at         |
|------|-------------------|----------|---------------------|--------------------|
| BLOB | test@google.com    | example  | 2025-02-12 06:46:43 | 2025-02-12 06:46:43 |

### elizaの返す文章を登録

| id   | sentence |
|------|----------|
| BLOB | Hi       |
| BLOB | Hola     |
| BLOB | アンニョン  |
| BLOB | Bonjour  |



### サーバーをたちげる
```sh
$ make run
```

# APIドキュメント

## **login**

リクエスト
```sh
$ curl --location --request POST 'http://localhost:8080/auth.v1.AuthService/Login' \
--header "Content-Type: application/json" \
--data '{"email": "test@google.com", "password": "example"}'
```

レスポンス
```sh
{
  "token": "access_token"
}
```

## **say**
```sh
リクエスト
$ curl --location --request POST 'http://localhost:8080/eliza.v1.ElizaService/CreateSentence' \
--header "Authorization: Bearer your_access_token" \
--header "Content-Type: application/json" \
--data '{"input": "Hello Eliza!"}'
```

レスポンス
```sh
{
  "sentence": "Hi"
}
```

## **createSectence**
リクエスト
```sh
$ curl --location --request POST 'http://localhost:8080/eliza.v1.ElizaService/CreateSentence' \
--header "Authorization: Bearer access_token" \
--header "Content-Type: application/json" \
--data '{"input": "add sentence"}'
```

レスポンス
```sh
{
  "sentence": "add sentence"
}
```

# 参考
- https://github.com/amitshekhariitbhu/go-backend-clean-architecture
- https://github.com/7oh2020/connect-tasklist
