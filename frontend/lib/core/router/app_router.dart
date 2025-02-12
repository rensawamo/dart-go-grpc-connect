import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/router/app_route_data.dart';
import 'package:frontend/core/router/routes.dart';
import 'package:go_router/go_router.dart';
final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.login,
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
