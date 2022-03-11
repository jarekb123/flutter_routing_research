import 'dart:async';

import 'package:rxdart/rxdart.dart';

class AuthService {
  final BehaviorSubject<bool> authState = BehaviorSubject.seeded(false);

  void login() => authState.add(true);

  bool isAuthenticated() => authState.value;
}
