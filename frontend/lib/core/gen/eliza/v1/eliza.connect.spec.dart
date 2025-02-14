//
//  Generated code. Do not modify.
//  source: eliza/v1/eliza.proto
//

import "package:connectrpc/connect.dart" as connect;
import "eliza.pb.dart" as elizav1eliza;

abstract final class ElizaService {
  /// Fully-qualified name of the ElizaService service.
  static const name = 'eliza.v1.ElizaService';

  static const say = connect.Spec(
    '/$name/Say',
    connect.StreamType.unary,
    elizav1eliza.SayRequest.new,
    elizav1eliza.SayResponse.new,
  );

  static const createSentence = connect.Spec(
    '/$name/CreateSentence',
    connect.StreamType.unary,
    elizav1eliza.CreateSentenceRequest.new,
    elizav1eliza.CreateSentenceResponse.new,
  );
}
