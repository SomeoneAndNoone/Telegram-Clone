import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_events.dart';
import 'package:telegram_clone/bloc/authentication/authentication_states.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/common_colors.dart';
import 'package:telegram_clone/pages/authentication/login/login_screen.dart';
import 'package:telegram_clone/pages/authentication/registration/registration_screen.dart';
import 'package:telegram_clone/pages/authentication/splash_screen/input_text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _email = '';

  void onTextChanged(String email) {
    _email = email;
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
                BlocBuilder<AuthenticationBloc, AuthenticationStates>(
                  buildWhen: (prevState, currentState) {
                    if (currentState is AuthenticationShouldLoginState) {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (context) {
                            return LoginScreen(email: currentState.email);
                          },
                        ),
                      );
                      return false;
                    } else if (currentState is AuthenticationShouldRegisterState) {
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (context) {
                            return RegistrationScreen(email: currentState.email);
                          },
                        ),
                      );
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
          hint: 'Enter email',
          errorText: errorMsg,
          onTextChanged: onTextChanged,
        ),
        SizedBox(height: AppSizes.padding15),
        MaterialButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationVerifyEmailEvent(email: _email));
          },
          child: Text(
            'NEXT',
            style: TextStyle(color: Colors.white),
          ),
          color: primaryLight,
        ),
      ],
    );
  }
}
