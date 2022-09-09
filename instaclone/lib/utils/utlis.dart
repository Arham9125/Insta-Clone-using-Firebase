

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  } else {
    print("NO image is selected");
  }
}

showSnackBar(String content, BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(content)));
}

// NextScreen(BuildContext context, String next) {
//   Navigator.push(context, MaterialPageRoute(builder: (context) => next));
// }
