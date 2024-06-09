import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import 'package:qrcode_app/pages/bloc/theme/theme_bloc.dart';
import 'package:qrcode_app/pages/freetogame/provider/game_provider.dart';
import 'package:qrcode_app/pages/product/bloc/product_bloc.dart';
import 'package:qrcode_app/routes/router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (context) => GameProvider(),
            child: MaterialApp.router(
              theme: state is ThemeStateLight ? ThemeData.light() : ThemeData
                  .dark(),
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}