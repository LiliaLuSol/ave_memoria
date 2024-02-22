import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ave_memoria/other/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sizer/sizer.dart';
//import 'package:ave_memoria/blocs/Auth/bloc/authentication_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeDateFormatting('ru', null);
  await PrefUtils().init();
  // await Supabase.initialize(
  //   url: 'https://wapchyqqghlrtcvsrayd.supabase.co',
  //   anonKey:
  //   'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndhcGNoeXFxZ2hscnRjdnNyYXlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTgyMTk5MTQsImV4cCI6MjAxMzc5NTkxNH0.76D6D-Kzc5B5u9_FO-WdW2cXIaJjyEdiXA8jI-b37Bo',
  //   authFlowType: AuthFlowType.pkce,
  //   debug: false,
  // );
  // Bloc.observer = MyBlocObserver();
  runApp(
    // MultiBlocProvider(
    //   providers: [
    //     // BlocProvider<AuthenticationBloc>(
    //     //   create: (_) => AuthenticationBloc(),
    //     // ),
    //   ],
    //   child: const
      MyApp()
    // ,
    // ),
    // //MyApp());
  );
}

//final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => ThemeBloc(
    //     ThemeState(
    //       themeType: PrefUtils().getThemeData(),
    //     ),
    //   ),
    //   child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: theme.colorScheme.background,
              systemNavigationBarColor: theme.colorScheme.background,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
            ),
            child:
            //return
            Sizer(
                builder: (context, orientation, deviceType) =>
                    MaterialApp.router(
                      theme: ThemeData(
                          scaffoldBackgroundColor:
                          theme.colorScheme.background),
                      title: 'ave_memoria',
                      debugShowCheckedModeBanner: false,
                      routeInformationProvider:
                      AppRoutes.router.routeInformationProvider,
                      routeInformationParser:
                      AppRoutes.router.routeInformationParser,
                      routerDelegate: AppRoutes.router.routerDelegate,
                      scrollBehavior:
                      const MaterialScrollBehavior().copyWith(
                        dragDevices: {
                          PointerDeviceKind.mouse,
                          PointerDeviceKind.touch,
                          PointerDeviceKind.stylus,
                          PointerDeviceKind.unknown
                        },
                      ),
                    )));
      }
      // ),
    // );
  // }
}
