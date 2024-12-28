import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:twitter_clone/constants.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/state_notifiers/auth_state_notifier.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wimpdljdpaocqbztnvfq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndpbXBkbGpkcGFvY3FienRudmZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzM3NzQzNDQsImV4cCI6MTk4OTM1MDM0NH0.Ybvbm0fWdFoK9OXsiGrp2thml-xmnDIBHVM4P1wT1Sg',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Widget _page(AppAuthState appAuthState) {
    if (appAuthState is AppAuthSignedOut) {
      return const LoginPage();
    } else if (appAuthState is AppAuthSignedIn) {
      return const Scaffold(body: preloader);
    } else if (appAuthState is AppAuthProfileLoaded) {
      return const HomePage();
    } else {
      throw UnimplementedError(
          'Unknown AppAuthState: ${appAuthState.runtimeType}');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appAuthState = ref.watch(appAuthProvider);
    return MaterialApp(
      title: 'Twitter Clone',
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey, width: 1),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.black),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          elevation: 1,
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(color: Colors.grey, width: 1),
            ),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
        ),
      ),
      home: _page(appAuthState),
    );
  }
}
