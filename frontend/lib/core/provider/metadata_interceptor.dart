import 'package:connectrpc/connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/state/model/token.dart';
import 'package:frontend/core/state/token_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_interceptor.g.dart';

@riverpod
MetadataInterceptor metaDataInterceptor(
  Ref ref,
) {
  final token = ref.read(tokenNotifierProvider);
  return MetadataInterceptor(token);
}

class MetadataInterceptor {
  const MetadataInterceptor(this.token);
  final Token token;

  AnyFn<I, O> call<I extends Object, O extends Object>(AnyFn<I, O> next) {
    return (req) async {
      // 10秒のタイムアウトを設定
      final signal = TimeoutSignal(const Duration(seconds: 10));
      // Headerに認証情報を追加
      req.headers.add('Authorization', 'Bearer ${token.accessToken}');
      // req.headers.add('DeviceToken', 'Bearer $token.deviceToken'); ...etc

      switch (req) {
        case UnaryRequest<I, O>(message: final message):
          return next(
            UnaryRequest<I, O>(
              req.spec,
              req.url,
              req.headers,
              message,
              signal,
            ),
          );

        case StreamRequest<I, O>(message: final message):
          return next(
            StreamRequest<I, O>(
              req.spec,
              req.url,
              req.headers,
              message,
              signal,
            ),
          );
      }
    };
  }
}
