import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/bloc/authentication/authentication_bloc.dart';
import 'package:telegram_clone/bloc/authentication/authentication_events.dart';
import 'package:telegram_clone/bloc/authentication/authentication_states.dart';
import 'package:telegram_clone/common/app_sizes.dart';
import 'package:telegram_clone/common/common_colors.dart';
import 'package:telegram_clone/common/constants/general_constants.dart';
import 'package:telegram_clone/common/providers/application_state.dart';
import 'package:telegram_clone/common/widgets/custom_input.dart';
import 'package:telegram_clone/pages/authentication/widgets/password_input.dart';
import 'package:telegram_clone/pages/home/home_page.dart';
import 'package:telegram_clone/routes.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({this.email});

  final String email;

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String _password;
  String _confirmPassword;
  String _username;
  String _picture;

  void _onPasswordChanged(String password) {
    _password = password;
  }

  void _onConfirmPasswordChanged(String confirmPassword) {
    _confirmPassword = confirmPassword;
  }

  void _onUsernameChanged(String username) {
    _username = username;
  }

  void _selectAvatar(String newAvatar) {
    _picture = newAvatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.padding10),
            child: Center(
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: AppSizes.padding15),
                  Text(
                    'Registration',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: primaryLight, fontSize: 35, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: AppSizes.padding15),
                  Text(
                    widget.email,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: AppSizes.padding15),
                  PasswordInput(
                    hint: '12345',
                    label: 'New Password',
                    onTextChanged: _onPasswordChanged,
                    isEnabled: true,
                  ),
                  SizedBox(height: AppSizes.padding15),
                  PasswordInput(
                    hint: '12345',
                    label: 'Confirm Password',
                    onTextChanged: _onConfirmPasswordChanged,
                    isEnabled: true,
                  ),
                  SizedBox(height: AppSizes.padding15),
                  SizedBox(height: AppSizes.padding15),
                  CustomInput(
                    hint: 'Username',
                    label: 'Harry Johnson',
                    onTextChanged: _onUsernameChanged,
                    isEnabled: true,
                  ),
                  SizedBox(height: AppSizes.padding15),
                  SizedBox(height: AppSizes.padding15),
                  Text(
                    'Choose Avatar',
                    style: TextStyle(color: primaryLight, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: AppSizes.padding15),
                  _SelectAvatar(onAvatarChanged: _selectAvatar),
                  SizedBox(height: AppSizes.padding15),
                  BlocBuilder<AuthenticationBloc, AuthenticationStates>(
                    buildWhen: (prevState, curState) {
                      if (curState is AuthenticationLoggedInState) {
                        Provider.of<ApplicationState>(context, listen: false)
                            .setActiveUser(curState.activeUser);

                        Navigator.pushNamedAndRemoveUntil(
                            context, TelegramRoutes.home, (_) => false);
                        return false;
                      }
                      return true;
                    },
                    builder: (context, state) {
                      if (state is AuthenticationErrorSate) {
                        return Text(
                          state.error,
                          style: TextStyle(color: Colors.red, fontSize: 16),
                          textAlign: TextAlign.center,
                        );
                      } else if (state is AuthenticationOnProgressState) {
                        return Column(
                          children: [
                            CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(primaryLight)),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  SizedBox(height: AppSizes.padding15),
                  MaterialButton(
                    color: primaryLight,
                    child: Text(
                      'DONE',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationRegisterEvent(
                        email: widget.email,
                        password: _password,
                        confirmPassword: _confirmPassword,
                        picture: _picture,
                        username: _username,
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectAvatar extends StatefulWidget {
  const _SelectAvatar({@required this.onAvatarChanged, this.picture});

  final Function(String newAvatar) onAvatarChanged;
  final String picture;
  @override
  __SelectAvatarState createState() => __SelectAvatarState();
}

class __SelectAvatarState extends State<_SelectAvatar> {
  String _currentPicture;

  @override
  void initState() {
    super.initState();
    _currentPicture = widget.picture;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List<int>.generate(GeneralConstants.PICTURE_INT, (i) => i)
          .map<Widget>(
            (e) => InkWell(
              onTap: () {
                _currentPicture = 'assets/profile_photos/photo_$e.png';
                widget.onAvatarChanged(_currentPicture);
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: _currentPicture == 'assets/profile_photos/photo_$e.png'
                      ? primaryLight.withOpacity(0.3)
                      : Colors.transparent,
                ),
                margin: EdgeInsets.only(right: AppSizes.padding10, bottom: AppSizes.padding10),
                padding: EdgeInsets.all(AppSizes.padding10),
                width: 80,
                height: 80,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 30,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/profile_photos/photo_$e.png',
                      // fit: BoxFit.fill,
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
