# サーバーの立ち上げ

## backendに移動してdirenvを読み込む
```sh
$ cd backend && direnv allow
```

## DockerのMySqlを立ち上げる
```sh
$ make up
```

## マイグレーションアップ
※ 同じくディレクトリ環境変数を読み込み
```sh
$ make migrate-up
```

## サーバーをたちげる
```sh
$ make run
```



```sh
$ export ACCESS_TOKEN=$(curl --silent --header "Content-Type: application/json" \
--data '{"email": "test@google.com", "password": "example"}' \
http://localhost:8080/auth.v1.AuthService/Login | jq -r '.token')


curl --header "Authorization: Bearer $ACCESS_TOKEN" \
--header "Content-Type: application/json" \
--data '{}' \
http://localhost:8080/eliza.v1.ElizaService/Say


curl --header "Authorization: Bearer $ACCESS_TOKEN" \
--header "Content-Type: application/json" \
--data '{"input": "Create a new sentence based on this input."}' \
http://localhost:8080/eliza.v1.ElizaService/CreateSentence


```
