import 'package:bloc_state_management/services/auth_provider.dart';
import 'package:bloc_state_management/services/bloc/auth_bloc.dart';
import 'package:bloc_state_management/utils/loading_screen.dart';
import 'package:bloc_state_management/views/home_page.dart';
import 'package:bloc_state_management/views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => AuthBloc(userAuthProvider: UserAuthProvider()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth State With Bloc',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const BlocNavigate(),
    );
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthBlocState>(
      builder: (BuildContext context, state) {
        if (state is AuthStateUninitialized) {
          return const LoginPage();
        } else if (state is AuthStateAuthenticated) {
          return const HomePage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      listener: (BuildContext context, Object? state) {
        if(state is AuthStateLoading) {
          return LoadingScreen().show(context: context, text: 'Loading...');
        } else {
          return LoadingScreen().hide();
        }
      },
    );
  }
}
