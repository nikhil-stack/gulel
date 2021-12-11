import 'package:flutter/material.dart';

class EditCategory extends StatelessWidget {
  //const EditCategory({ Key? key }) : super(key: key);
  final String title;
  final String imageUrl;
  final String categoryKey;
  EditCategory(this.title, this.imageUrl, this.categoryKey);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(categoryKey),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
    );
  }
}
