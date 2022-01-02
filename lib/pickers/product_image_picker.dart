import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class ProductImagePicker extends StatefulWidget {
  //const ProductImagePicker({ Key? key }) : super(key: key);
  final void Function(File pickedImage) imagePickfn;
  ProductImagePicker(this.imagePickfn);

  @override
  _ProductImagePickerState createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File _pickedImage;
  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 500,
    );
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickfn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          backgroundColor: Colors.grey,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
