//
//  Generated code. Do not modify.
//  source: eliza/v1/eliza.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'eliza.pb.dart' as $1;
import 'eliza.pbjson.dart';

export 'eliza.pb.dart';

abstract class ElizaServiceBase extends $pb.GeneratedService {
  $async.Future<$1.SayResponse> say($pb.ServerContext ctx, $1.SayRequest request);
  $async.Future<$1.CreateSentenceResponse> createSentence($pb.ServerContext ctx, $1.CreateSentenceRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Say': return $1.SayRequest();
      case 'CreateSentence': return $1.CreateSentenceRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Say': return this.say(ctx, request as $1.SayRequest);
      case 'CreateSentence': return this.createSentence(ctx, request as $1.CreateSentenceRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ElizaServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => ElizaServiceBase$messageJson;
}

