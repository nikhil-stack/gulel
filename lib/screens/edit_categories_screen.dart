import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/widgets/edit_category.dart';
import 'package:provider/provider.dart';

class EditCategoriesScreen extends StatelessWidget {
  //const EditCategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CategoryItems_Provider>(context).categories;
    print(prov.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Categories'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => EditCategory(
          prov[index].title,
          prov[index].imageUrl,
          prov[index].id,
        ),
        itemCount: prov.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed('/add-category'),
      ),
    );
  }
}
