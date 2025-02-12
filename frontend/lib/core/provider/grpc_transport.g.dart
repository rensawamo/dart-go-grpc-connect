// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grpc_transport.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$grpcTransportHash() => r'87c0d0e0eae1abb762a1cf7bce2e43ba72cf3d12';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [grpcTransport].
@ProviderFor(grpcTransport)
const grpcTransportProvider = GrpcTransportFamily();

/// See also [grpcTransport].
class GrpcTransportFamily extends Family<Transport> {
  /// See also [grpcTransport].
  const GrpcTransportFamily();

  /// See also [grpcTransport].
  GrpcTransportProvider call({
    bool isRequireMetaData = true,
  }) {
    return GrpcTransportProvider(
      isRequireMetaData: isRequireMetaData,
    );
  }

  @override
  GrpcTransportProvider getProviderOverride(
    covariant GrpcTransportProvider provider,
  ) {
    return call(
      isRequireMetaData: provider.isRequireMetaData,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'grpcTransportProvider';
}

/// See also [grpcTransport].
class GrpcTransportProvider extends Provider<Transport> {
  /// See also [grpcTransport].
  GrpcTransportProvider({
    bool isRequireMetaData = true,
  }) : this._internal(
          (ref) => grpcTransport(
            ref as GrpcTransportRef,
            isRequireMetaData: isRequireMetaData,
          ),
          from: grpcTransportProvider,
          name: r'grpcTransportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$grpcTransportHash,
          dependencies: GrpcTransportFamily._dependencies,
          allTransitiveDependencies:
              GrpcTransportFamily._allTransitiveDependencies,
          isRequireMetaData: isRequireMetaData,
        );

  GrpcTransportProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isRequireMetaData,
  }) : super.internal();

  final bool isRequireMetaData;

  @override
  Override overrideWith(
    Transport Function(GrpcTransportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GrpcTransportProvider._internal(
        (ref) => create(ref as GrpcTransportRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isRequireMetaData: isRequireMetaData,
      ),
    );
  }

  @override
  ProviderElement<Transport> createElement() {
    return _GrpcTransportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GrpcTransportProvider &&
        other.isRequireMetaData == isRequireMetaData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isRequireMetaData.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GrpcTransportRef on ProviderRef<Transport> {
  /// The parameter `isRequireMetaData` of this provider.
  bool get isRequireMetaData;
}

class _GrpcTransportProviderElement extends ProviderElement<Transport>
    with GrpcTransportRef {
  _GrpcTransportProviderElement(super.provider);

  @override
  bool get isRequireMetaData =>
      (origin as GrpcTransportProvider).isRequireMetaData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
