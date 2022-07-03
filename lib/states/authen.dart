import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:unggoodstudent/models/user_model.dart';
import 'package:unggoodstudent/states/my_service.dart';
import 'package:unggoodstudent/utility/my_constant.dart';
import 'package:unggoodstudent/utility/my_dialog.dart';
import 'package:unggoodstudent/widgets/show_button.dart';
import 'package:unggoodstudent/widgets/show_form.dart';
import 'package:unggoodstudent/widgets/show_image.dart';
import 'package:unggoodstudent/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            newLogo(),
            newTitle(),
            formUser(),
            formPassword(),
            buttonLogin(),
          ],
        ),
      ),
    );
  }

  Container buttonLogin() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(top: 8),
      child: ShowButton(
        label: 'Login',
        pressFunc: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            MyDialog(context: context).normalDialog(
                title: 'Have Space ?', subTitle: 'Please Fill Every Blank');
          } else {
            processCheckLogin();
          }
        },
      ),
    );
  }

  Future<void> processCheckLogin() async {
    String path =
        'https://www.androidthai.in.th/goodstd/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      if (value.toString() == 'null') {
        MyDialog(context: context).normalDialog(
            title: 'User False ?', subTitle: 'No $user in my Database');
      } else {
        for (var element in json.decode(value.data)) {
          print('element ==> $element');
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyService(
                    userModel: userModel,
                  ),
                ),
                (route) => false);
          } else {
            MyDialog(context: context).normalDialog(
                title: 'Password False',
                subTitle: 'Please Try Again Password False');
          }
        }
      }
    });
  }

  Container formPassword() {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(top: 16),
      child: ShowForm(
        hint: 'Password :',
        iconData: Icons.lock_outline,
        changeFunc: (String string) {
          password = string.trim();
        },
      ),
    );
  }

  Container formUser() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      child: ShowForm(
        hint: 'User :',
        iconData: Icons.perm_identity,
        changeFunc: (String string) {
          user = string.trim();
        },
      ),
    );
  }

  ShowText newTitle() => ShowText(
        text: 'Logo:',
        textStyle: MyConstant().h1Style(),
      );

  SizedBox newLogo() {
    return const SizedBox(
      width: 80,
      child: ShowImage(),
    );
  }
}
