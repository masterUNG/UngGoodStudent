// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:unggoodstudent/bodys/check_id_student.dart';

import 'package:unggoodstudent/models/user_model.dart';
import 'package:unggoodstudent/utility/my_constant.dart';
import 'package:unggoodstudent/widgets/show_text.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  const MyService({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: ShowText(
          text: userModel!.nameTeacher,
          textStyle: MyConstant().h2WhiteStyle(),
        ),
      ),
      body: CheckIdStudent(idTeacher: userModel!.id,),
    );
  }
}
