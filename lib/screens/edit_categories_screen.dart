import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/widgets/edit_category.dart';
import 'package:provider/provider.dart';

class EditCategoriesScreen extends StatefulWidget {
  //const EditCategoriesScreen({ Key? key }) : super(key: key);

  @override
  _EditCategoriesScreenState createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<CategoryItems_Provider>(context)
          .fetchAndSetCategories()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<CategoryItems_Provider>(context).categories;
    print(prov.length);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Categories'),
      ),
      body: prov.length == 0 ? Center(child: Text('No Categories Found!'),) : _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
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
