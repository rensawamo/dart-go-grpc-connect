import 'package:flutter/widgets.dart';
import 'package:frontend/eliza/eliza_page.dart';
import 'package:frontend/login/login_page.dart';
import 'package:frontend/router/app_navigation_bar.dart';
import 'package:frontend/router/routes.dart';
import 'package:go_router/go_router.dart';

part 'app_route_data.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  static final GlobalKey<NavigatorState> $navigatorKey = rootNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppNavigationBar(
      navigationShell: navigationShell,
    );
  }
}

@TypedGoRoute<LoginRouteData>(
  path: Routes.login,
  routes: <TypedGoRoute<GoRouteData>>[],
)
class LoginRouteData extends GoRouteData {
  const LoginRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginPage();
  }
}

@TypedGoRoute<ElizaRouteData>(
  path: Routes.eliza,
)
class ElizaRouteData extends GoRouteData {
  const ElizaRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatPage();
  }
}
