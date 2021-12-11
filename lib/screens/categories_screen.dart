import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/widgets/Bottom_navigation.dart';
import 'package:gulel/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  //const CategoriesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CategoryItems_Provider>(context).categories;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Gulel'),
        ),
      ),
      body: GridView.builder(
        itemCount: prov.length,
        itemBuilder: (ctx, index) => CategoryItem(
            prov[index].id, prov[index].title, prov[index].imageUrl),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.9,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
      bottomNavigationBar: BottomNavigationBarClass(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.category),
        onPressed: () => Navigator.of(context).pushNamed('/edit-category'),
      ),
    );
  }
}
