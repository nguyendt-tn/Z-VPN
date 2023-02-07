import 'package:flutter/material.dart';
import 'package:nz_vpn/core/provider/server_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nz_vpn/core/constants/language_constants.dart';
import 'package:nz_vpn/core/representation/screens/splash_screen.dart';
import 'package:nz_vpn/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ServerNotifier())],
      builder: (context, child) => MaterialApp(
        title: 'VPN',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFFFFFFFF),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: SplashScreen.routeName,
      ),
    );
  }
}
