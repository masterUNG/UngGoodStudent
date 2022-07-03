// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:unggoodstudent/models/profile_student_model.dart';
import 'package:unggoodstudent/utility/my_constant.dart';
import 'package:unggoodstudent/utility/my_dialog.dart';
import 'package:unggoodstudent/widgets/show_button.dart';
import 'package:unggoodstudent/widgets/show_image.dart';
import 'package:unggoodstudent/widgets/show_text.dart';

class CutPoint extends StatefulWidget {
  final String idTeacher;
  final ProfileStudentModel profileStudentModel;
  const CutPoint({
    Key? key,
    required this.idTeacher,
    required this.profileStudentModel,
  }) : super(key: key);

  @override
  State<CutPoint> createState() => _CutPointState();
}

class _CutPointState extends State<CutPoint> {
  String? idTeacher;
  ProfileStudentModel? profileStudentModel;
  String? dateTimeCutPoint;

  var wrongDoings = MyConstant.wrongdoings;
  var wrongPoints = MyConstant.wrongPoints;
  var indexDropdowns = <int>[];
  int? indexDropdown;
  File? file;

  @override
  void initState() {
    super.initState();
    idTeacher = widget.idTeacher;
    profileStudentModel = widget.profileStudentModel;

    DateTime dateTime = DateTime.now();
    dateTimeCutPoint = dateTime.toString();

    for (var i = 0; i < wrongDoings.length; i++) {
      indexDropdowns.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShowText(
          text: profileStudentModel!.nameStudent,
          textStyle: MyConstant().h2WhiteStyle(),
        ),
        backgroundColor: MyConstant.primary,
      ),
      body: Center(
        child: Column(
          children: [
            newImage(),
            newTimes(),
            dropDownWrong(),
            buttonSaveCutPoint(),
          ],
        ),
      ),
    );
  }

  ShowButton buttonSaveCutPoint() {
    return ShowButton(
      label: 'Save Cut Point',
      pressFunc: () {
        if (file == null) {
          MyDialog(context: context).normalDialog(
              title: 'Non Photo ?', subTitle: 'Please Take Photo');
        } else if (indexDropdown == null) {
          MyDialog(context: context).normalDialog(
              title: 'Non Wrong ?', subTitle: 'Please Choose Worng');
        } else {}
      },
    );
  }

  DropdownButton<dynamic> dropDownWrong() {
    return DropdownButton<dynamic>(
      hint: const ShowText(text: 'โปรดเลือกความผิดผลาด'),
      value: indexDropdown,
      items: indexDropdowns
          .map(
            (e) => DropdownMenuItem(
              child: ShowText(
                text: '${wrongDoings[e]}  ===>>> ${wrongPoints[e]}',
              ),
              value: e,
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          indexDropdown = value;
        });
      },
    );
  }

  ShowText newTimes() {
    return ShowText(
      text: dateTimeCutPoint ?? '',
      textStyle: MyConstant().h2Style(),
    );
  }

  Container newImage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: file == null
                ? const ShowImage(
                    path: 'images/camera.png',
                  )
                : Image.file(file!),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
                onPressed: () {
                  processTakePhoto();
                },
                icon: Icon(
                  Icons.add_a_photo,
                  size: 36,
                  color: MyConstant.active,
                )),
          )
        ],
      ),
    );
  }

  Future<void> processTakePhoto() async {
    await ImagePicker()
        .pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
    )
        .then((value) {
      setState(() {
        file = File(value!.path);
      });
    });
  }
}
