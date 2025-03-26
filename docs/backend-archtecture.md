
# Go Backend Architecture
Overview

![Group 53](https://github.com/user-attachments/assets/213360f8-3e60-4796-b0f0-377b604a9a51)

This is a backend project built with Clean Architecture principles using Go.
It leverages the following technologies:

- **Mux（HTTP routing）**
- **MySQL(database）**
- **JWT for authentication middleware**
- **Docker**

## Architecture Layers
The application is composed of the following layers:

- **Router (Mux)**
Handles routing of client requests to the appropriate handlers.

- **Handler (Controller)**
Receives incoming requests and invokes corresponding use cases.

- **Usecase**
Implements business logic.

- **Repository**
Abstracts database interactions.

- **Domain (Model/Entity)**
Defines core data structures.

- **Dependency Injection (DI)**
Manages dependencies between layers to ensure loose coupling.


# Project Structure
```sh
backend/
├── api/
│   ├── handler/       # Controller layer
│   ├── interceptor/   # gRPC interceptors
├── cmd/               # Application entry point
├── database/          # DB setup and config
├── di/                # Dependency injection
├── domain/            # Domain models/entities
├── gen/               # Generated code (e.g., Protobuf)
├── internal/          # Internal packages
├── repository/        # Repository implementations
├── usecase/           # Business logic
```

# Request Flow

## Public API
<img width="529" alt="image" src="https://github.com/user-attachments/assets/7d830f16-12e2-4338-b01b-b7ebb03aa732" />


## Authenticated API
<img width="516" alt="image" src="https://github.com/user-attachments/assets/2ce62a77-e7a0-4457-8b92-f86be4bc761d" />


# SET UP
### Generate RSA Key Pair
```sh
$ ssh-keygen -t rsa -b 2048 -f $PRIVATE_KEY_PATH -N ""
$ ssh-keygen -p -m PEM -f $PRIVATE_KEY_PATH
```

Set the environment variable in backend/.envrc:
```sh
PRIVATE_KEY_PATH=YOURS
```

### Load direnv Environment
```sh
$ cd backend && direnv allow
```

### Start MySQL with Docker
```sh
$ make up
```

### Run Database Migrations
⚠️ Make sure environment variables are loaded.
This command registers a test user and predefined Eliza sentences.

```sh
$ make migrate-up
```

### Sample Test User

| id   | email             | password | created_at          | updated_at         |
|------|-------------------|----------|---------------------|--------------------|
| BLOB | test@google.com    | example  | 2025-02-12 06:46:43 | 2025-02-12 06:46:43 |

### Pre-registered Eliza Sentences

| id   | sentence |
|------|----------|
| BLOB | Hi       |
| BLOB | Hola     |
| BLOB | アンニョン  |
| BLOB | Bonjour  |


### Run the Server
```sh
$ make run
```

# API Documentation

## **Login**

Request:
```sh
$ curl --location --request POST 'http://localhost:8080/auth.v1.AuthService/Login' \
--header "Content-Type: application/json" \
--data '{"email": "test@google.com", "password": "example"}'
```

Response:
```sh
{
  "token": "access_token"
}
```

## **Say**
```sh
Request:
$ curl --location --request POST 'http://localhost:8080/eliza.v1.ElizaService/CreateSentence' \
--header "Authorization: Bearer your_access_token" \
--header "Content-Type: application/json" \
--data '{"input": "Hello Eliza!"}'
```

Response:
```sh
{
  "sentence": "Hi"
}
```

## **CreateSentence**
Request:
```sh
$ curl --location --request POST 'http://localhost:8080/eliza.v1.ElizaService/CreateSentence' \
--header "Authorization: Bearer access_token" \
--header "Content-Type: application/json" \
--data '{"input": "add sentence"}'
```

Response:
```sh
{
  "sentence": "add sentence"
}
```

# References
- https://github.com/amitshekhariitbhu/go-backend-clean-architecture
- https://github.com/7oh2020/connect-tasklist
