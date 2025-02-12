import 'package:connectrpc/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/gen/auth/v1/auth.connect.client.dart';
import 'package:frontend/core/gen/auth/v1/auth.pbserver.dart';
import 'package:frontend/core/provider/grpc_transport.dart';
import 'package:frontend/core/router/app_route_data.dart';
import 'package:frontend/core/state/token_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String?> _call() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      final response = await AuthServiceClient(
        ref.read(grpcTransportProvider),
      ).login(
        LoginRequest(email: email, password: password),
      );
      return response.token;
    } on ConnectException catch (e) {
      print('エラーが発生しました: $e');
    }
    return null;
  }

  Future<void> login() async {
    final token = await _call();
    if (token != null) {
      await ref.read(tokenNotifierProvider.notifier).saveAccessToken(token);
      if (mounted) {
        await const ElizaRouteData().push<void>(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ログインに失敗しました'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ログインページ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emailフィールド
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'メールアドレスを入力してください';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return '有効なメールアドレスを入力してください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // パスワードフィールド
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'パスワードを入力してください';
                  } else if (value.length < 6) {
                    return 'パスワードは6文字以上にしてください';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // ログインボタン
              ElevatedButton(
                onPressed: login,
                child: const Text('ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
