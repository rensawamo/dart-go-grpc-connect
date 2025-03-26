# Project Architecture
- **[Backend](https://github.com/rensawamo/dart-go-grpc-connect/blob/main/docs/backend-archtecture.md)**
- **[Frontend](https://github.com/rensawamo/dart-go-grpc-connect/blob/main/docs/frontend-archtecture.md)**

# Role of the proto Directory
The proto directory provides shared service definitions for both the backend and frontend.

This ensures that both client and server use the exact same interfaces, improving consistency and maintainability across the project.

```sh
$ make gen
```

This command generates Go and Dart code into their respective gen directories.

# Backend (Golang)

### Generate a project-specific private key:
```sh
$ ssh-keygen -t rsa -b 2048 -f $PRIVATE_KEY_PATH -N ""
$ ssh-keygen -p -m PEM -f $PRIVATE_KEY_PATH
```

Update your environment variables in backend/.envrc:
```sh
PRIVATE_KEY_PATH=YOURS
```

### Load direnv environment variables
```sh
$ cd backend && direnv allow
```

### Start MySQL using Docker
```sh
$ make up
```

### Run Migrations
⚠️ Make sure to load the environment again with direnv.
This step creates a default user and some Eliza responses in the database.

```sh
$ make migrate-up
```

### Sample User

| id   | email             | password | created_at          | updated_at         |
|------|-------------------|----------|---------------------|--------------------|
| BLOB | test@google.com    | example  | 2025-02-12 06:46:43 | 2025-02-12 06:46:43 |

### Sample Eliza Sentences

| id   | sentence |
|------|----------|
| BLOB | Hi       |
| BLOB | Hola     |
| BLOB | アンニョン  |
| BLOB | Bonjour  |


### Start the Backend Server
```sh
$ make run
```

# Frontend (Flutter)

```sh
$ cd frontend && flutter run
```

### App Flow
1. Login using the sample user to get an access token
2. Use the token in the header to call the Eliza API
3. The API will return one of the preset sentences randomly

<div style="display: flex; gap: 20px;"> <img src="https://github.com/user-attachments/assets/646b45b7-6a83-4a5d-be67-678b88938099" width="25%" /> <img src="https://github.com/user-attachments/assets/af48e9f7-2503-4bf3-8c4b-51359faa3640" width="25%" /> </div>


## Run via Project Root Make Commands

### Login and Get Access Token
```sh
$ make login
Getting access token...
ACCESS_TOKEN=.....
```

### Call the Eliza API
```sh
$ make say
Making request to 'Say' endpoint...
{"sentence":"アンニョン"}
```

### Bonus: Add More Sentences to Eliza
If you want Eliza to return more variety, you can add sentences like this:
```sh
$ make create_sentence input="add sentence"
Making request to 'CreateSentence' endpoint with input: add sentence
{"sentence":"add sentence"}
```
