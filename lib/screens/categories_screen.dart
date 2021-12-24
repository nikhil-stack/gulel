import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/user_Provider.dart';
import 'package:gulel/screens/cart_screen.dart';
import 'package:gulel/widgets/category_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesScreen extends StatefulWidget {
  //const CategoriesScreen({ Key? key }) : super(key: key);
  static const routeName = '\Cart-Screen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  bool _isAdmin = false;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      Provider.of<CategoryItems_Provider>(context).fetchAndSetCategories();
      Provider.of<user_provider>(context).fetchandset().then((_) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
    _isInit = false;
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('userId') == 'admin') {
      _isAdmin = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<CategoryItems_Provider>(context).categories;
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
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
      floatingActionButton: _isAdmin
          ? FloatingActionButton(
              child: Icon(Icons.category),
              onPressed: () =>
                  Navigator.of(context).pushNamed('/edit-category'),
            )
          : null,
    );
  }
}
