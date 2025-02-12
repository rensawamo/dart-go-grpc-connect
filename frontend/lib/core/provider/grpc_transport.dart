import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc.dart' as grpc;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/util/interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grpc_transport.g.dart';

@riverpod
Transport grpcTransport(
  Ref ref, {
  bool isRequireMetaData = true,
}) {
  final transport = grpc.Transport(
    baseUrl: 'http://localhost:8080',
    codec: const ProtoCodec(),
    httpClient: createHttpClient(),
    statusParser: const StatusParser(),
    interceptors: [
      const LoggingInterceptor(print).call,
      if (isRequireMetaData) const MetadataInterceptor().call,
    ],
  );

  return transport;
}
