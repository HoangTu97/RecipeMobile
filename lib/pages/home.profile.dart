import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/auth/index.dart';
import 'package:recipes/services/locator.dart';
import 'package:recipes/services/navigation.dart';

class HomeProfilePage extends StatefulWidget {
  @override
  HomeProfilePageState createState() => new HomeProfilePageState();
}

class HomeProfilePageState extends State<HomeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 300,
            alignment: Alignment.center,
            child: Container(
              width: 150,
              height: 150,
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: double.infinity,
                    backgroundImage: AssetImage("assets/avatar.jpg"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orangeAccent,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationAuthenticated) {
                    return Center(
                      child: Container(
                        height: 45,
                        width: 300,
                        child: RaisedButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LoggedOut());
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: Colors.redAccent[200],
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              Icon(Icons.input, color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Container(
                      height: 45,
                      width: 300,
                      child: RaisedButton(
                        onPressed: () {
                          locator<NavigationService>().pushNamed("/login");
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        color: Colors.grey[200],
                        child: Row(
                          children: <Widget>[
                            SizedBox(width: 10),
                            Icon(Icons.input),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
