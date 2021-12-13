import 'package:flutter/material.dart';
import 'package:gulel/models/products.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Product'),
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
                    category1: _newProduct.category1,
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
                    title: value,
                    price: _newProduct.price,
                    imageUrl: _newProduct.imageUrl,
                    stockAvailable: _newProduct.stockAvailable,
                    category1: _newProduct.category1,
                  );
                },
              ),
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
                    category1: _newProduct.category1,
                  );
                },
              ),
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
