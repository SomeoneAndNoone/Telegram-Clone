import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/bloc/authentication/authentication_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_events.dart';
import 'package:telegram_clone/bloc/authentication/authentication_states.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/common_colors.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/pages/authentication/splash_screen/input_text.dart';

import '../../../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({@required this.email});

  final String email;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _password = '';

  void onTextChanged(String password) {
    _password = password;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<AuthenticationBloc>(context).add(UninitializeAuthenticationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: AppSizes.padding15),
                Text(
                  'Telegram',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                SizedBox(height: 15),
                Text(widget.email),
                SizedBox(height: 15),
                BlocBuilder<AuthenticationBloc, AuthenticationStates>(
                  buildWhen: (prevState, currentState) {
                    if (currentState is AuthenticationLoggedInState) {
                      Provider.of<ApplicationState>(context, listen: false)
                          .setActiveUser(currentState.activeUser);

                      Navigator.pushNamedAndRemoveUntil(context, TelegramRoutes.home, (_) => false);
                      return false;
                    } else if (currentState is AuthenticationShouldRegisterState) {
                      Navigator.pushNamedAndRemoveUntil(context, TelegramRoutes.home, (_) => false);
                      return false;
                    }
                    return true;
                  },
                  builder: (context, state) {
                    debugPrint('Splash screen: $state');
                    if (state is AuthenticationUninitializedState) {
                      return _formFiled(null);
                    } else if (state is AuthenticationErrorSate) {
                      return _formFiled(state.error);
                    } else {
                      return CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(primaryLight));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formFiled(String errorMsg) {
    return Column(
      children: [
        InputText(
          isObscure: true,
          hint: 'Enter password',
          errorText: errorMsg,
          onTextChanged: onTextChanged,
        ),
        SizedBox(height: AppSizes.padding15),
        MaterialButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoginEvent(
                email: widget.email,
                password: _password,
              ),
            );
          },
          child: Text(
            'DONE',
            style: TextStyle(color: Colors.white),
          ),
          color: primaryLight,
        ),
      ],
    );
  }
}
