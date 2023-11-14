import 'dart:async';
import 'dart:developer';

import 'package:agro/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:agro/routes/app_pages.dart';
import 'package:agro/vars/locales.dart';
import 'package:agro/vars/model_notifier/user_notifier/user_notifier.dart';

import 'config/config.dart';
import 'load/load_screen.dart';
import 'model/model_user/model_user.dart';
import 'vars/model_notifier/bottom_menu_notifier/bottom_menu_notifier.dart';

bool startActive = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Color(0xff14175B),
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff14175B),
        systemNavigationBarIconBrightness: Brightness.light),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Hive.registerAdapter(ModelUserAdapter());

  await Hive.initFlutter();

  try {
    await Hive.openBox<String>('configs');
    await Hive.openBox('data');
  } catch (err) {
    log(err.toString());
  }

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LocaleManager>(create: (_) => LocaleManager()),
    ChangeNotifierProvider<BottomMenuNotifier>(create: (_) => BottomMenuNotifier()),
    ChangeNotifierProvider<UserNotifier>(create: (_) => UserNotifier()),
  ], child: const AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.light, child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: GetMaterialApp(
          navigatorKey: navigatorKey,
          builder: (context, child) {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: ScrollConfiguration(
                    behavior: const ScrollBehavior(),
                    child: ResponsiveWrapper.builder(child, minWidth: 500, defaultScale: true, breakpoints: [
                      const ResponsiveBreakpoint.autoScale(600, name: MOBILE),
                      const ResponsiveBreakpoint.resize(480, name: MOBILE),
                      const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                      const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                    ]),
                  )),
            );
          },
          locale: context.watch<LocaleManager>().locale,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.dark(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          getPages: AppPages.pages(context: context),
          transitionDuration: const Duration(milliseconds: 200),
          home: const Material(child: MyStart())),
    ));
  }
}

class MyStart extends HookWidget {
  const MyStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() {});
    return FutureBuilder<String>(
        future: future,
        builder: (c, snapshot) {
          if (!startActive) load(c);
          startActive = true;
          return const LoadScreen();
        });
  }

  Future load(BuildContext c) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (c.mounted) {
      ModelUser? modelUser = Hive.box('data').get('modelUser');
      if (modelUser != null && modelUser.token != null) {
        Get.offAllNamed(Routes.app);
      } else {
        Get.offAllNamed(Routes.auth);
      }
    }
  }
}
