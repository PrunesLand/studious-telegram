import 'package:flutter/cupertino.dart';

class MyNavigatorObserver extends NavigatorObserver {
  final List<Route<dynamic>> _routeStack = [];

  int get stackCount => _routeStack.length;

  @override
  void didPush(Route route, Route? previousRoute) {
    _routeStack.add(route);
    print('Route pushed: ${route.settings.name}, stack size: ${stackCount}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _routeStack.remove(route);
    print('Route popped: ${route.settings.name}, stack size: ${stackCount}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _routeStack.remove(route);
    print('Route removed: ${route.settings.name}, stack size: ${stackCount}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) {
      _routeStack.remove(oldRoute);
    }
    if (newRoute != null) {
      _routeStack.add(newRoute);
    }
    print('Route replaced, stack size: ${stackCount}');
  }
}
