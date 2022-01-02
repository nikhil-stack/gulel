import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/models/category.dart';
import 'package:provider/provider.dart';
import 'package:gulel/pickers/product_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddCategoryScreen extends StatefulWidget {
  //const AddCategoryScreen({ Key? key }) : super(key: key);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _form = GlobalKey<FormState>();
  var _newCategory = Category(id: '', title: '', imageUrl: '');
  //final _imageUrlController = TextEditingController();
  File _categoryImageFile;
  bool _isLoading = false;

  void _saveForm(File image) async {
    setState(() {
      _isLoading = true;
    });
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    final ref = FirebaseStorage.instance
        .ref()
        .child('category_image')
        .child(DateTime.now().toString() + '.jpg');
    await ref.putFile(image).onComplete;
    final url = await ref.getDownloadURL();
    _newCategory = Category(
      id: _newCategory.id,
      title: _newCategory.title,
      imageUrl: url,
    );
    Provider.of<CategoryItems_Provider>(context, listen: false)
        .addCategories(_newCategory);
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _pickedImage(File image) {
    _categoryImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new category'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => _saveForm(_categoryImageFile),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _newCategory = Category(
                          id: _newCategory.id,
                          title: value,
                          imageUrl: _newCategory.imageUrl,
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ProductImagePicker(_pickedImage),
                    /*Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter a URL')
                        : Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      controller: _imageUrlController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a URL';
                        } else {
                          return null;
                        }
                      },
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onSaved: (value) {
                        _newCategory = Category(
                          id: _newCategory.id,
                          title: _newCategory.title,
                          imageUrl: value,
                        );
                      },
                    ),
                  ),
                ],
              ),*/
                  ],
                ),
              ),
            ),
    );
  }
}
