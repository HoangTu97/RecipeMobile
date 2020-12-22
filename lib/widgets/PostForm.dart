import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes/blocs/auth/index.dart';

import 'dialog/Message.dart';

class PostForm extends StatelessWidget {
  const PostForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(right: 10),
                      child: CircleAvatar(
                        radius: double.infinity,
                        backgroundImage: AssetImage("assets/avatar.jpg"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (!(state is AuthenticationAuthenticated)) {
                          MsgDialog.show(context, "Authorize",
                              "You need login to use this feature");
                          return;
                        }
                      },
                      child: Text('Viet mon moi'),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.video_call),
                      label: Text('Quay quy trinh'),
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {
                        if (!(state is AuthenticationAuthenticated)) {
                          MsgDialog.show(context, "Authorize",
                              "You need login to use this feature");
                          return;
                        }
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.photo),
                      label: Text('Anh'),
                      style: TextButton.styleFrom(
                        primary: Colors.teal,
                      ),
                      onPressed: () {
                        if (!(state is AuthenticationAuthenticated)) {
                          MsgDialog.show(context, "Authorize",
                              "You need login to use this feature");
                          return;
                        }
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.location_on),
                      label: Text('Dia diem'),
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                      ),
                      onPressed: () {
                        if (!(state is AuthenticationAuthenticated)) {
                          MsgDialog.show(context, "Authorize",
                              "You need login to use this feature");
                          return;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
