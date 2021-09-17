import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_meter/src/core/cubit/auth_cubit.dart';
import 'package:sugar_meter/src/navigation/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  static Widget create() {
    //Listener of Auth sTate streams
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        /*if the user is signed-in or signed-out,
        it will display either home page or sign in page*/
        if (state is AuthSignedOut) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.signIn, (r) => false);
        } else if (state is AuthSignedIn) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (r) => false);
        }
      },
      child: const SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
