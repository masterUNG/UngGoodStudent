// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:unggoodstudent/utility/my_constant.dart';

class ShowForm extends StatelessWidget {
  final String hint;
  final IconData iconData;
  final Function(String) changeFunc;
  final Function()? pressFunc;
  const ShowForm({
    Key? key,
    required this.hint,
    required this.iconData,
    required this.changeFunc,
    this.pressFunc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        border: const OutlineInputBorder(),
        hintText: hint,
        suffixIcon: pressFunc == null
            ? Icon(iconData)
            : IconButton(onPressed: pressFunc, icon: Icon(iconData, color: MyConstant.active,)),
      ),
      onChanged: changeFunc,
    );
  }
}
