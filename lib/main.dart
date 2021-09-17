import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sugar_meter/src/app.dart';
import 'package:sugar_meter/src/core/auth_repository/implementations/auth_repository.dart';
import 'package:sugar_meter/src/core/cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final _authRepo = AuthRepository();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => AuthCubit(_authRepo)),
    ],
    child: const MyApp(),
  ));
}
