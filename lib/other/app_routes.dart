import 'package:ave_memoria/pages/load_screen.dart';
import 'package:ave_memoria/pages/onboard.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/main.dart';
import 'package:go_router/go_router.dart';
import 'app_export.dart';

class AppRoutes {
  static const root = '/';
  static const load = '/load_screen';
  static const onboard = '/onboard';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          // if (supabase.auth.currentUser != null) {
            return const Onboard();
          // } else {
          //   return const Onboard();
          // }
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
     ],
    // initialLocation: root,
    // errorBuilder: (context, state) => const ScreenLayout(
    //     child: Center(
    //   child: Text("Страница не найдена!"),
    // )),
  );

  static GoRouter get router => _router;
}
