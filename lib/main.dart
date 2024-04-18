import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting('ru', null);
  await PrefUtils().init();
  await Supabase.initialize(
    url:
    anonKey:
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
    debug: false,
  );
  Bloc.observer = MyBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(
        ThemeState(
          themeType: PrefUtils().getThemeData(),
        ),
      ),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: theme.colorScheme.onPrimaryContainer,
              systemNavigationBarColor: theme.colorScheme.onPrimaryContainer,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark,
            ),
            child: Sizer(
                builder: (context, orientation, deviceType) =>
                    MaterialApp.router(
                      theme: ThemeData(
                          scaffoldBackgroundColor:
                              theme.colorScheme.background,
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: theme.colorScheme.primary.withOpacity(0.5),
                          cursorColor: theme.colorScheme.primary,
                          selectionHandleColor: theme.colorScheme.primary
                        ),),
                      title: 'ave_memoria',
                      debugShowCheckedModeBanner: false,
                      routeInformationProvider:
                          AppRoutes.router.routeInformationProvider,
                      routeInformationParser:
                          AppRoutes.router.routeInformationParser,
                      routerDelegate: AppRoutes.router.routerDelegate,
                      scrollBehavior: const MaterialScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                          PointerDeviceKind.stylus,
                          PointerDeviceKind.unknown
                        },
                      ),
                    )));
      }),
    );
  }
}
