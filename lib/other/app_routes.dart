import 'package:ave_memoria/pages/new_password_screen.dart';
import 'package:ave_memoria/pages/support.dart';
import 'package:flutter/material.dart';
import 'package:ave_memoria/pages/authorization.dart';
import 'package:ave_memoria/pages/base_screen.dart';
import 'package:ave_memoria/pages/load_screen.dart';
import 'package:ave_memoria/pages/onboard.dart';
import 'package:ave_memoria/pages/auth_reg.dart';
import 'package:ave_memoria/pages/registration.dart';
import 'package:ave_memoria/main.dart';
import 'package:ave_memoria/pages/screen_layout.dart';
import '../games/cards_game/gaming_cards.dart';
import '../games/image_game/gaming_image.dart';
import '../games/sequence_game/gaming_sequence.dart';
import '../pages/forget_screen.dart';
import 'app_export.dart';

class AppRoutes {
  static const root = '/';
  static const load = '/load_screen';
  static const onboard = '/onboard';
  static const authreg = '/auth_reg';
  static const authorization = '/authorization';
  static const registration = '/regisrtration';
  static const homepage = '/homepage';
  static const support = '/support';
  static const game_cards = '/gaming_cards';
  static const game_sequence = '/gaming_sequence';
  static const game_image = '/gaming_image';
  static const forgetScreen = '/forget_screen';
  static const new_password = '/new_password_screen';
  static const dialog = '/dialog_game';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          if (supabase.auth.currentUser != null &&
              supabase.auth.currentUser?.email != "anounymous@gmail.com") {
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
        path: support,
        builder: (context, state) => const Support(),
      ),
      GoRoute(
        path: forgetScreen,
        builder: (context, state) => const ForgetScreen(),
      ),
      GoRoute(
        path: new_password,
        builder: (context, state) => const NewPasswordScreen(),
      ),
      GoRoute(
        path: homepage,
        builder: (context, state) => const BaseScreen(),
      ),
      GoRoute(
        path: game_cards,
        builder: (context, state) => const CardsGame(),
      ),
      GoRoute(
        path: game_sequence,
        builder: (context, state) => const SequenceGame(),
      ),
      GoRoute(
        path: game_image,
        builder: (context, state) => const ImageGame(),
      ),
    ],
    initialLocation: root,
    errorBuilder: (context, state) => ScreenLayout(
        child: Center(
      child: Text("Страница не найдена!",
          style: CustomTextStyles.semiBold32Primary),
    )),
  );

  static GoRouter get router => _router;
}
