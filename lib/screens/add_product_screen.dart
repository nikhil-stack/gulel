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
    price: 0,
    imageUrl: '',
    stockAvailable: 0,
    category1: '',
  );
  final _imageUrlController = TextEditingController();

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<CategoryItems_Provider>(context, listen: false)
        .addProduct(_newProduct);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final categoryy = routeArgs['categoryName'];
    final categoryId = routeArgs['categoryId'];
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryy),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
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
                  );
                },
              ),
              TextFormField(
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
                  );
                },
              ),
              TextFormField(
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
                  );
                },
              ),
              TextFormField(
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
