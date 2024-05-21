import 'package:agro/di/service_locator.dart';
import 'package:agro/repositories/auth_repository.dart';
import 'package:agro/routes/app_pages.dart';
import 'package:agro/screens/app/authentification/bloc/authentication_bloc.dart';
import 'package:agro/screens/app/push_notifications_bloc/push_notifications_bloc.dart';
import 'package:agro/screens/app/role_bloc/role_bloc.dart';
import 'package:agro/screens/splash_page.dart';
import 'package:agro/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loggy/loggy.dart';

class App extends StatelessWidget {
  App({
    super.key,
  });

  final AuthenticationRepository authenticationRepository =
      getIt<AuthenticationRepository>();

  @override
  Widget build(BuildContext context) {
    final pushNotificationsBloc = PushNotificationsBloc();
    final AuthenticationBloc authenticationBloc = AuthenticationBloc(
        authenticationRepository: authenticationRepository,
        pushNotificationsBloc);
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: authenticationBloc,
          ),
          BlocProvider.value(
            value: pushNotificationsBloc,
          )
        ],
        child: AppView(authenticationBloc: authenticationBloc),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key, required this.authenticationBloc});
  final AuthenticationBloc authenticationBloc;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RoleBloc(getIt.get()),
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.black,
            ),
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ).apply(
              bodyColor: AppColors.black,
              displayColor: AppColors.black,
            ),
            primaryColor: AppColors.green,
          ),
          builder: (context, child) => MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                logDebug("Auth Status: ${state.status}");
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    BlocProvider.of<RoleBloc>(context).add(GetRole());
                    Get.offAllNamed(Routes.app);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    Get.offAllNamed(Routes.auth);
                    break;
                  case AuthenticationStatus.unknown:
                    break;
                }
              })
            ],
            child: child!,
          ),
          onGenerateRoute: (_) => SplashPage.route(),
        ));
  }
}
