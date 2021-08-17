import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flutter/bloc/login/login_bloc.dart';
import 'package:login_flutter/bloc/producto/producto_bloc.dart';
import 'package:login_flutter/pages/home_page.dart';
import 'package:login_flutter/pages/login_page.dart';
import 'package:login_flutter/repositories/repositories.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                ProductoBloc(productoRepository: ProductoRepository())),
        BlocProvider(
            create: (BuildContext context) =>
                LoginBloc(authRepository: AuthRepository()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'login',
          routes: {
            'login': (context) => LoginPage(),
            'producto': (context) => HomePage(),
          }),
    );
  }
}
