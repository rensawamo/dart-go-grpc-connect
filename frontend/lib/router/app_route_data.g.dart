// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route_data.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $loginRouteData,
      $elizaRouteData,
    ];

RouteBase get $loginRouteData => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteDataExtension._fromState,
    );

extension $LoginRouteDataExtension on LoginRouteData {
  static LoginRouteData _fromState(GoRouterState state) =>
      const LoginRouteData();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $elizaRouteData => GoRouteData.$route(
      path: '/eliza',
      factory: $ElizaRouteDataExtension._fromState,
    );

extension $ElizaRouteDataExtension on ElizaRouteData {
  static ElizaRouteData _fromState(GoRouterState state) =>
      const ElizaRouteData();

  String get location => GoRouteData.$location(
        '/eliza',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
