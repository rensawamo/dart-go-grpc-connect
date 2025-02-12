import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc.dart' as grpc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/provider/metadata_interceptor.dart';
import 'package:frontend/core/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grpc_transport.g.dart';

@Riverpod(keepAlive: true)
Transport grpcTransport(
  Ref ref, {
  bool isRequireMetaData = true,
}) {
  final metadataInterceptor = ref.watch(metaDataInterceptorProvider);

  final transport = grpc.Transport(
    baseUrl: 'http://localhost:8080',
    codec: const ProtoCodec(),
    httpClient: createHttpClient(),
    statusParser: const StatusParser(),
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
      logger
        ..d('Request: $req')
        ..d('Headers: ${req.headers}');
      switch (res) {
        case StreamResponse<I, O>():
          return StreamResponse(
            res.spec,
            res.headers,
            _logEach(res.message),
            res.trailers,
          );
        case UnaryResponse<I, O>(message: final message):
          logger.d(message);
          return res;
      }
    };
  }

  Stream<T> _logEach<T>(Stream<T> stream) async* {
    await for (final next in stream) {
      logger.d('Response: $next');
      yield next;
    }
  }
}
