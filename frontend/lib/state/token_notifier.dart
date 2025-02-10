import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/di_provider/secure_storage_provider.dart';
import 'package:frontend/state/model/token.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_notifier.g.dart';

@Riverpod(keepAlive: true)
class TokenNotifier extends _$TokenNotifier {
  late final FlutterSecureStorage _secureStorage;
  final _key = 'accessToken';

  @override
  Token build() {
    _secureStorage = ref.read(secureStorageProvider);
    return const Token();
  }

  Future<void> initState() async {
    final accessToken = await _secureStorage.read(key: _key) ?? '';

    state = Token(
      accessToken: accessToken,
    );
  }

  Future<void> saveAccessToken(String token) async {
    await _secureStorage.write(key: _key, value: token);
    state = state.copyWith(accessToken: token);
  }

  Future<void> clearAll() async {
    await _secureStorage.delete(key: _key);
    state = const Token();
  }
}
