import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifexp_app/core/router/app_router.dart';
import 'package:lifexp_app/core/theme/app_theme.dart';

class LifeXPApp extends StatefulWidget {
  const LifeXPApp({super.key, this.isAuthenticated = false, this.authStateChanges});

  final bool isAuthenticated;
  final Stream<bool>? authStateChanges;

  @override
  State<LifeXPApp> createState() => _LifeXPAppState();
}

class _LifeXPAppState extends State<LifeXPApp> {
  late final ValueNotifier<bool> _authenticationState;
  late final GoRouter _router;
  StreamSubscription<bool>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _authenticationState = ValueNotifier(widget.isAuthenticated);
    _router = AppRouter.createRouter(authenticationState: _authenticationState);
    _authSubscription = widget.authStateChanges?.listen((isAuthenticated) {
      _authenticationState.value = isAuthenticated;
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _router.dispose();
    _authenticationState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LifeXP',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
