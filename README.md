
```sh
$ export ACCESS_TOKEN=$(curl --silent --header "Content-Type: application/json" \
--data '{"email": "test@google.com", "password": "example"}' \
http://localhost:8080/auth.v1.AuthService/Login | jq -r '.token')


curl --header "Authorization: Bearer $ACCESS_TOKEN" \
--header "Content-Type: application/json" \
--data '{}' \
http://localhost:8080/eliza.v1.ElizaService/Say

```
