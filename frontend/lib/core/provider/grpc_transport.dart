import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc.dart' as grpc;
import 'package:connectrpc/test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/gen/eliza/v1/eliza.connect.spec.dart';
import 'package:frontend/core/gen/eliza/v1/eliza.pb.dart';
import 'package:frontend/core/util/interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grpc_transport.g.dart';

@riverpod
Transport grpcTransport(Ref ref) {
  // テスト用のTransportを作成
  final fakeTransport = FakeTransportBuilder().unary(
    ElizaService.say,
    (_, __) async {
      return SayResponse(sentence: 'I feel happy.');
    },
  ).build();

  // 本番用のTransportを作成
  final transport = grpc.Transport(
    baseUrl: 'https://demo.connectrpc.com',
    // Protobufの代わりに JSONを使用する場合 ▶️ codec: const JsonCodec()
    codec: const ProtoCodec(), // Protobufを使用する場合
    httpClient: createHttpClient(),
    statusParser: const StatusParser(), //gRPC をトランスポート プロトコルとして使用する場合
    interceptors: [
      const LoggingInterceptor(print).call,
      const MetadataInterceptor().call,
    ],
  );

  if (kDebugMode) {
    return fakeTransport;
  } else {
    return transport;
  }
}
