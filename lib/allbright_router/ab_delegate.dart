import 'package:flutter/widgets.dart';
import 'package:router_experiments/allbright_router/recognized_url.dart';

abstract class ABRoute {}

class ABPageRoute<T> implements ABRoute {
  final Page<T> page;
  final bool initial;

  ABPageRoute({
    required this.page,
    this.initial = false,
  });
}

class ABRouterDelegate
    with ChangeNotifier
    implements RouterDelegate<RecognizedUrl> {
  final Map<String, ABRoute> routes;

  ABRouterDelegate({
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    return Navigator();
  }

  RecognizedUrl? _currentConfiguration;

  @override
  RecognizedUrl? get currentConfiguration => _currentConfiguration;


  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  Future<void> setInitialRoutePath(RecognizedUrl configuration) {
    // TODO: implement setInitialRoutePath
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(RecognizedUrl configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

  @override
  Future<void> setRestoredRoutePath(RecognizedUrl configuration) {
    // TODO: implement setRestoredRoutePath
    throw UnimplementedError();
  }

  RecognizedUrl _getInitialUrl() {
    
  }
}
