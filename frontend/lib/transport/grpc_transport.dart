import 'package:connectrpc/connect.dart';
import 'package:connectrpc/http2.dart';
import 'package:connectrpc/test.dart';
import 'package:eliza/gen/eliza.connect.spec.dart';
import 'package:eliza/gen/eliza.pb.dart';
import 'package:eliza/interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protobuf.dart' as protobuf;
import 'package:connectrpc/protobuf.dart';
import 'package:connectrpc/protocol/grpc.dart' as grpc;

import 'package:flutter/foundation.dart';

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
    baseUrl: "https://demo.connectrpc.com",
    // Protobufの代わりに JSONを使用する場合 ▶️ codec: const JsonCodec()
    codec: const ProtoCodec(), // Protobufを使用する場合
    httpClient: createHttpClient(),
    statusParser: const protobuf.StatusParser(), //gRPC をトランスポート プロトコルとして使用する場合
    interceptors: [
      const LoggingInterceptor(print),
      const MetadataInterceptor(),
    ],
  );

  if (kDebugMode) {
    return fakeTransport;
  } else {
    return transport;
  }
}
