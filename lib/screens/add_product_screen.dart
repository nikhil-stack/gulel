import 'package:flutter/material.dart';
import 'package:gulel/Providers/categoryItems.dart';
import 'package:gulel/Providers/products.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  //const AddProductScreen({ Key? key }) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();
  var _newProduct = Product(
    id: '',
    title: '',
    price: null,
    imageUrl: '',
    stockAvailable: null,
    category1: '',
  );
  //final _imageUrlController = TextEditingController();
  var _isInit = true;

  var _isLoading = false;

  Map<String, dynamic> _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'stockAvailable': '',
  };

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_newProduct.id.isEmpty) {
      await Provider.of<CategoryItems_Provider>(context, listen: false)
          .addProduct(
        _newProduct,
      );
    } else {
      await Provider.of<CategoryItems_Provider>(
        context,
        listen: false,
      ).updateProduct(
        _newProduct.id,
        _newProduct,
      );
    }
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final data =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final productId = data['productId'];
      if (productId != null) {
        _newProduct =
            Provider.of<CategoryItems_Provider>(context).findById(productId);
        //print(_newProduct.price);
        print(_newProduct.stockAvailable);
        _initValues = {
          'title': _newProduct.title,
          'description': _newProduct.description,
          'price': double.tryParse(_newProduct.price.toString()),
          'imageUrl': _newProduct.imageUrl,
          'stockAvailable': int.tryParse(_newProduct.stockAvailable.toString()),
        };
        //print('priceeeeeeeee' + _initValues['price']);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final categoryy = routeArgs['categoryName'];
    final categoryId = routeArgs['categoryId'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
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
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: value,
                          price: _newProduct.price,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: categoryId,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          price: _newProduct.price,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: categoryId,
                          isFavourite: _newProduct.isFavourite,
                          description: value,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'].toString(),
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          price: double.tryParse(value),
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['imageUrl'],
                      decoration: InputDecoration(labelText: 'ImageUrl'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a Image URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          price: _newProduct.price,
                          imageUrl: value,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['stockAvailable'].toString(),
                      decoration: InputDecoration(labelText: 'Stock Available'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide Stock Available';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          price: _newProduct.price,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: int.tryParse(value),
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
