import 'package:ave_memoria/pages/load_screen.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/main.dart';
import 'package:go_router/go_router.dart';
import 'app_export.dart';

class AppRoutes {
  static const root = '/';
  static const load = '/app_routes.dart';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          // if (supabase.auth.currentUser != null) {
            return const LoadScreen();
          // } else {
          //   return const Onboard();
          // }
        },
      ),
      GoRoute(
        path: load,
        builder: (context, state) => const LoadScreen(),
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
