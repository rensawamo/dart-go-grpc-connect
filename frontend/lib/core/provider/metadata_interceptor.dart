import 'package:connectrpc/connect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/state/model/token.dart';
import 'package:frontend/core/state/token_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'metadata_interceptor.g.dart';

@Riverpod(keepAlive: true)
MetadataInterceptor metaDataInterceptor(
  Ref ref,
) {
  final token = ref.watch(tokenNotifierProvider);
  return MetadataInterceptor(token);
}

class MetadataInterceptor {
  const MetadataInterceptor(
    this.token,
  );
  final Token token;

  AnyFn<I, O> call<I extends Object, O extends Object>(AnyFn<I, O> next) {
    return (req) async {
      req.headers.add('Authorization', 'Bearer ${token.accessToken}');
      // req.headers.add('DeviceToken', 'Bearer $token.deviceToken');  etc..
      return next(req);
    };
  }
}
