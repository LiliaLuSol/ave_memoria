import 'package:ave_memoria/pages/confirm_email.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/pages/authorization.dart';
import 'package:ave_memoria/pages/base_screen.dart';
import 'package:ave_memoria/pages/load_screen.dart';
import 'package:ave_memoria/pages/onboard.dart';
import 'package:ave_memoria/pages/auth_reg.dart';
import 'package:ave_memoria/pages/registration.dart';
import 'package:ave_memoria/main.dart';
import 'package:ave_memoria/pages/screen_layout.dart';
import 'package:go_router/go_router.dart';
import 'app_export.dart';

class AppRoutes {
  static const root = '/';
  static const load = '/load_screen';
  static const onboard = '/onboard';
  static const authreg = '/auth_reg';
  static const authorization = '/authorization';
  static const registration = '/regisrtration';
  static const confirmemail = '/confirm_email';
  static const homepage = '/homepage';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          if (supabase.auth.currentUser != null) {
            return const BaseScreen();
          } else {
            return const Onboard();
          }
        },
      ),
      GoRoute(
        path: load,
        builder: (context, state) => const LoadScreen(),
      ),
      GoRoute(
        path: onboard,
        builder: (context, state) => const Onboard(),
      ),
      GoRoute(
        path: authreg,
        builder: (context, state) => const AuthReg(),
      ),
      GoRoute(
        path: authorization,
        builder: (context, state) => const Authorization(),
      ),
      GoRoute(
        path: registration,
        builder: (context, state) => const Registration(),
      ),
      GoRoute(
        path: confirmemail,
        builder: (context, state) => const ConfirmEmail(),
      ),
      GoRoute(
        path: homepage,
        builder: (context, state) => const BaseScreen(),
      ),
     ],
    initialLocation: root,
    errorBuilder: (context, state) => const ScreenLayout(
        child: Center(
      child: Text("Страница не найдена!"),
    )),
  );

  static GoRouter get router => _router;
}
