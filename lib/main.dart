import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifexp_app/core/app.dart';
import 'package:lifexp_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: LifeXPApp(
        isAuthenticated: FirebaseAuth.instance.currentUser != null,
        authStateChanges: FirebaseAuth.instance
            .authStateChanges()
            .map((user) => user != null),
      ),
    ),
  );
}
