import 'dart:io';

import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/connect.dart' as protocol;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/provider/metadata_interceptor.dart';
import 'package:frontend/core/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transport.g.dart';

@riverpod
Transport transport(
  Ref ref, {
  bool isRequireMetaData = true,
}) {
  final metadataInterceptor = ref.read(metaDataInterceptorProvider);

  final transport = protocol.Transport(
    baseUrl:
        Platform.isAndroid ? 'http://10.0.2.2:8080' : 'http://localhost:8080',
    codec: const ProtoCodec(),
    httpClient: createHttpClient(),
    interceptors: [
      const LoggingInterceptor().call,
      if (isRequireMetaData) metadataInterceptor.call,
    ],
  );

  return transport;
}

class LoggingInterceptor {
  const LoggingInterceptor();
  AnyFn<I, O> call<I extends Object, O extends Object>(AnyFn<I, O> next) {
    return (req) async {
      final res = await next(req);
      printLongText('url: ${req.url}');
      printLongText('Header Entries: ${req.headers.entries}');
      printLongText('Trailer Entries: ${res.trailers.entries}');
      switch (res) {
        case StreamResponse<I, O>():
          return StreamResponse(
            res.spec,
            res.headers,
            _logEach(res.message),
            res.trailers,
          );
        case UnaryResponse<I, O>(message: final message):
          printLongText('Response: $message');
          return res;
      }
    };
  }

  Stream<T> _logEach<T>(Stream<T> stream) async* {
    await for (final next in stream) {
      printLongText('Response: $next');
      yield next;
    }
  }
}
