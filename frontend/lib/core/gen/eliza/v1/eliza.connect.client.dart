//
//  Generated code. Do not modify.
//  source: eliza/v1/eliza.proto
//

import "package:connectrpc/connect.dart" as connect;
import "eliza.pb.dart" as elizav1eliza;
import "eliza.connect.spec.dart" as specs;

extension type ElizaServiceClient (connect.Transport _transport) {
  Future<elizav1eliza.SayResponse> say(
    elizav1eliza.SayRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ElizaService.say,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<elizav1eliza.CreateSentenceResponse> createSentence(
    elizav1eliza.CreateSentenceRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.ElizaService.createSentence,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
