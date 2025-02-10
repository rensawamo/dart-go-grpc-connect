//
//  Generated code. Do not modify.
//  source: eliza/v1/eliza.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SayRequest extends $pb.GeneratedMessage {
  factory SayRequest({
    $core.String? sentence,
  }) {
    final $result = create();
    if (sentence != null) {
      $result.sentence = sentence;
    }
    return $result;
  }
  SayRequest._() : super();
  factory SayRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SayRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SayRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'eliza.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sentence')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SayRequest clone() => SayRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SayRequest copyWith(void Function(SayRequest) updates) => super.copyWith((message) => updates(message as SayRequest)) as SayRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SayRequest create() => SayRequest._();
  SayRequest createEmptyInstance() => create();
  static $pb.PbList<SayRequest> createRepeated() => $pb.PbList<SayRequest>();
  @$core.pragma('dart2js:noInline')
  static SayRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SayRequest>(create);
  static SayRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sentence => $_getSZ(0);
  @$pb.TagNumber(1)
  set sentence($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSentence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSentence() => clearField(1);
}

class SayResponse extends $pb.GeneratedMessage {
  factory SayResponse({
    $core.String? sentence,
  }) {
    final $result = create();
    if (sentence != null) {
      $result.sentence = sentence;
    }
    return $result;
  }
  SayResponse._() : super();
  factory SayResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SayResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SayResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'eliza.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'sentence')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SayResponse clone() => SayResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SayResponse copyWith(void Function(SayResponse) updates) => super.copyWith((message) => updates(message as SayResponse)) as SayResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SayResponse create() => SayResponse._();
  SayResponse createEmptyInstance() => create();
  static $pb.PbList<SayResponse> createRepeated() => $pb.PbList<SayResponse>();
  @$core.pragma('dart2js:noInline')
  static SayResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SayResponse>(create);
  static SayResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get sentence => $_getSZ(0);
  @$pb.TagNumber(1)
  set sentence($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSentence() => $_has(0);
  @$pb.TagNumber(1)
  void clearSentence() => clearField(1);
}

class ElizaServiceApi {
  $pb.RpcClient _client;
  ElizaServiceApi(this._client);

  $async.Future<SayResponse> say($pb.ClientContext? ctx, SayRequest request) =>
    _client.invoke<SayResponse>(ctx, 'ElizaService', 'Say', request, SayResponse())
  ;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
