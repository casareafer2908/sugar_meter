import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_meter/src/core/cubit/auth_cubit.dart';
import 'package:sugar_meter/src/navigation/routes.dart';
import 'package:sugar_meter/src/ui/common_widgets/sign_in_button.dart';
import 'package:sugar_meter/src/ui/common_widgets/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedIn) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (r) => false);
        }
      },
      child: const SignInPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugar meter'),
        elevation: 2,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthSignedOut) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 48.0),
                SocialSignInButton(
                  assetName: 'assets/images/google-logo.png',
                  text: 'Sign in with Google',
                  color: Colors.white,
                  textColor: Colors.black87,
                  onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
                ),
                const SizedBox(height: 8.0), //space between widgets
                SocialSignInButton(
                  assetName: 'assets/images/facebook-logo.png',
                  text: 'Sign in with Facebook',
                  color: const Color(0xFF334D92),
                  textColor: Colors.white,
                  onPressed: () =>
                      context.read<AuthCubit>().signInWithFacebook(),
                ),
                const SizedBox(height: 8.0), //space between widgets
                SignInButton(
                  text: 'Sign in with email',
                  color: Colors.teal[700],
                  textColor: Colors.white,
                  //TODO: implement Email and pass sign-in
                  onPressed: () {},
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0), //space between widgets
                SignInButton(
                  text: 'Go Anonymous',
                  color: Colors.lime[300],
                  textColor: Colors.black87,
                  onPressed: () =>
                      context.read<AuthCubit>().signInAnonymously(),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
