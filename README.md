# バックエンド(Golang)

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

# フロントエンド(Flutter)

```sh
$ cd frontend/flutter run
```

①上記のマイグレーションで登録されているユーザーでログインをして、
アクセストークンを得ます。

②アクセストークンをヘッダーにセットして、ElizaApiにリクエストを送ります。


そうすると、際ほどマイグレーションで登録した文章のうち1つが、ランダムで返ってきます。

<div style="display: flex; gap: 20px;"> <img src="https://github.com/user-attachments/assets/646b45b7-6a83-4a5d-be67-678b88938099" width="25%" /> <img src="https://github.com/user-attachments/assets/af48e9f7-2503-4bf3-8c4b-51359faa3640" width="25%" /> </div>


## プロジェクトルートコマンドからも実行可能

### ログインしてアクセストークン取得
```sh
$ make login
Getting access token...
ACCESS_TOKEN=.....
```

### Eliza Api実行
```sh
$ make say
Making request to 'Say' endpoint...
{"sentence":"アンニョン"}
```

### おまけ
Elizaから返ってくる文章が、マイグレーションしたものだけだと物足りない場合、
以下のコマンドからバリエーションを増やせます。
```sh
$ make create_sentence input="add sentence"
Making request to 'CreateSentence' endpoint with input: add sentence
{"sentence":"add sentence"}
```
