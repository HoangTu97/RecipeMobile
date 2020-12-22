import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:recipes/blocs/login/index.dart';
import 'package:recipes/style/theme.dart' as Theme;

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureTextLogin = true;

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();

    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Card(
                    elevation: 2.0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      width: 300.0,
                      height: 190.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) =>
                                  _loginBloc.add(LoginUsernameChanged(value)),
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                hintText: "Username",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                                errorText: state.form.username.invalid
                                    ? "Invalid username."
                                    : null,
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: TextField(
                              onChanged: (value) =>
                                  _loginBloc.add(LoginPasswordChanged(value)),
                              obscureText: _obscureTextLogin,
                              style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 17.0,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    _obscureTextLogin
                                        ? FontAwesomeIcons.eye
                                        : FontAwesomeIcons.eyeSlash,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                                errorText: state.form.password.invalid
                                    ? "Invalid password"
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 170.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.loginGradientStart,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.loginGradientEnd,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientStart
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: state.status == FormzStatus.submissionInProgress
                            ? CircularProgressIndicator()
                            : Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                      ),
                      onPressed: () => _loginBloc.add(LoginSubmitted()),
                    ),
                  ),
                ],
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                )),
          ),
        ],
      ),
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
