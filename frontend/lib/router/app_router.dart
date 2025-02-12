import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/di_provider/shard_preferences_with_cache_provider.dart';
import 'package:frontend/router/app_route_data.dart';
import 'package:frontend/router/routes.dart';
import 'package:go_router/go_router.dart';

/// アプリ全体の 宣言的なルーティングを提供するProvider
final routerProvider = Provider((ref) {
  final pref = ref.watch(sharedPreferencesWithCacheProvider);
  var isLogined = pref.getBool('isLogined') ?? false;
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: isLogined ? Routes.eliza : Routes.login,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorWidget(
        Exception('Route for ${state.uri} not found'),
      ),
    ),
    redirect: (context, state) {
      return null;
    },
  );
});
