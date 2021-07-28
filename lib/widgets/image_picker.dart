import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.addImage);
  final void Function(File pickedImage) addImage;
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  void _addImage() async {
    final File pickedImage = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 120,
    );
    setState(() {
      _pickedImage = pickedImage;
    });
    widget.addImage(pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _addImage,
          icon: Icon(Icons.image),
          label: Text('Add an image'),
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
