
# Go バックエンドアーキテクチャ
概要

![Group 53](https://github.com/user-attachments/assets/213360f8-3e60-4796-b0f0-377b604a9a51)

Goのバックエンド クリーンアーキテクチャのプロジェクトです。
このプロジェクトでは、以下の技術を使用しています

- **Mux（HTTP ルーティング）**
- **MongoDB（データベース）**
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
![go-arch-public-api-request-flow (1)](https://github.com/user-attachments/assets/b6165a6f-f544-476e-9502-4049568d617b)


## 認証付きAPI
![go-arch-private-api-request-flow](https://github.com/user-attachments/assets/3216ad56-452a-4a6b-ad53-858e8d05ba91)


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
- https://github.com/rensawamo/go-backend-clean-architecture
- https://github.com/7oh2020/connect-tasklist
