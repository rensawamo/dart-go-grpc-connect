// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transport.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transportHash() => r'29375306268645a93f98805609d3945b334bec8a';

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

/// See also [transport].
@ProviderFor(transport)
const transportProvider = TransportFamily();

/// See also [transport].
class TransportFamily extends Family<Transport> {
  /// See also [transport].
  const TransportFamily();

  /// See also [transport].
  TransportProvider call({
    bool isRequireMetaData = true,
  }) {
    return TransportProvider(
      isRequireMetaData: isRequireMetaData,
    );
  }

  @override
  TransportProvider getProviderOverride(
    covariant TransportProvider provider,
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
  String? get name => r'transportProvider';
}

/// See also [transport].
class TransportProvider extends AutoDisposeProvider<Transport> {
  /// See also [transport].
  TransportProvider({
    bool isRequireMetaData = true,
  }) : this._internal(
          (ref) => transport(
            ref as TransportRef,
            isRequireMetaData: isRequireMetaData,
          ),
          from: transportProvider,
          name: r'transportProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transportHash,
          dependencies: TransportFamily._dependencies,
          allTransitiveDependencies: TransportFamily._allTransitiveDependencies,
          isRequireMetaData: isRequireMetaData,
        );

  TransportProvider._internal(
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
    Transport Function(TransportRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransportProvider._internal(
        (ref) => create(ref as TransportRef),
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
  AutoDisposeProviderElement<Transport> createElement() {
    return _TransportProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransportProvider &&
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
mixin TransportRef on AutoDisposeProviderRef<Transport> {
  /// The parameter `isRequireMetaData` of this provider.
  bool get isRequireMetaData;
}

class _TransportProviderElement extends AutoDisposeProviderElement<Transport>
    with TransportRef {
  _TransportProviderElement(super.provider);

  @override
  bool get isRequireMetaData => (origin as TransportProvider).isRequireMetaData;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
