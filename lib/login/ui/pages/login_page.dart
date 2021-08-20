import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_flutter/login/bloc/login/login_bloc.dart';
import 'package:login_flutter/login/repositories/repositories.dart';
import 'package:login_flutter/login/ui/input_decorations.dart';
import 'package:login_flutter/login/ui/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              SizedBox(height: 10),
              Text('Login', style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 30),
              _LoginForm()
            ],
          )),
          SizedBox(height: 50),
          Text(
            'Crear una nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  bool guardado = false;
  AuthRepository? authRepository;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ErrorBlocState) {
            // escucha la acción que hace el blocbuilder mostrar errores, mensajes sirve el
            _showError(context, state.message);
            setState(() {
              guardado = false;
            });
          }
          if (state is LoggedInBlocState) {
            Navigator.pushNamed(context, 'producto');
            /*  Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => HomePage())); */
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'ejemplo@gmail.com',
                        labelText: 'Correo electrónico',
                        prefixIcon: Icons.alternate_email_rounded),
                    onChanged: (value) {}, //=> loginForm.email = value,
                    validator: (value) {
                      String pattern =
                          r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regExp = new RegExp(pattern);

                      return regExp.hasMatch(value ?? '')
                          ? null
                          : 'El valor ingresado no parece como un correo';
                    },
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: password,
                    autocorrect: false,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecorations.authInputDecoration(
                        hintText: '*****',
                        labelText: 'Contraseña',
                        prefixIcon: Icons.lock_outline),
                    onChanged: (value) {}, // => loginForm.password = value,
                    validator: (value) {
                      return (value != null && value.length >= 6)
                          ? null
                          : 'La contraseña debe de ser de 6 caracteres';
                    },
                  ),
                  SizedBox(height: 30),
                  // msg,
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        disabledColor: Colors.grey,
                        elevation: 0,
                        color: Colors.deepPurple,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            child: Text(
                              guardado ? 'Espere' : 'Ingresar',
                              style: TextStyle(color: Colors.white),
                            )),
                        onPressed: (guardado) ? null : _doLogin,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _doLogin() {
    //FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate())
      return; // para validar que el formulario cumple con los datos sugeridos
    formKey.currentState!.save();
    BlocProvider.of<LoginBloc>(context)
        .add(LoginButtonPressed(email: email.text, password: password.text));
    setState(() {
      guardado = true;
    });
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
