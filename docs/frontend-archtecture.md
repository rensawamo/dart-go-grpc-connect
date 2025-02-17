
# Frontend ディレクトリ構造

```sh
frontend/
├── core/
│   ├── gen/          # コード生成（Connectサービス）
│   ├── provider/     # Riverpod Generatorを利用した依存関係の注入
│   ├── router/       # 画面遷移の管理
│   ├── state/        # SSOT状態管理
│   ├── util/         # loggerなど
├── feature/
│   ├── eliza/        # Eliza機能の実装
│   ├── login/        # 認証機能の実装
├── app.dart         
├── main.dart        
```
