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
    imageUrl: '',
    stockAvailable: null,
    category1: '',
    five: null,
    ten: null,
    twenty: null,
    thirty: null,
    fifty: null,
    seventyFive: null,
    hundred: null,
    delhiPrice: null,
    bikanerPrice: null,
    kolkataPrice: null,
    varanasiPrice: null,
    hyderabadPrice: null,
  );
  //final _imageUrlController = TextEditingController();
  var _isInit = true;

  var _isLoading = false;

  Map<String, dynamic> _initValues = {
    'title': '',
    'description': '',
    'imageUrl': '',
    'stockAvailable': '',
    'five': '',
    'ten': '',
    'twenty': '',
    'thirty': '',
    'fifty': '',
    'seventyFive': '',
    'hundred': '',
    'DelhiNCR': '',
    'Hyderabad': '',
    'Bikaner': '',
    'Varanasi': '',
    'Kolkata': '',
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
          'imageUrl': _newProduct.imageUrl,
          'stockAvailable': int.tryParse(_newProduct.stockAvailable.toString()),
          'five': _newProduct.five == 0 ? '' : _newProduct.five,
          'ten': _newProduct.ten == 0 ? '' : _newProduct.ten,
          'twenty': _newProduct.twenty == 0 ? '' : _newProduct.twenty,
          'thirty': _newProduct.thirty == 0 ? '' : _newProduct.thirty,
          'fifty': _newProduct.fifty == 0 ? '' : _newProduct.fifty,
          'seventyFive':
              _newProduct.seventyFive == 0 ? '' : _newProduct.seventyFive,
          'hundred': _newProduct.hundred == 0 ? '' : _newProduct.hundred,
          'DelhiNCR': double.tryParse( _newProduct.delhiPrice.toString()),
          'Hyderabad': double.tryParse( _newProduct.hyderabadPrice.toString()),
          'Varanasi': double.tryParse( _newProduct.varanasiPrice.toString()),
          'Bikaner': double.tryParse( _newProduct.bikanerPrice.toString()),
          'Kolkata': double.tryParse( _newProduct.kolkataPrice.toString()),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: categoryId,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: categoryId,
                          isFavourite: _newProduct.isFavourite,
                          description: value,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    
                    TextFormField(
                      initialValue: _initValues['DelhiNCR'].toString(),
                      decoration: InputDecoration(labelText: 'Price for Delhi NCR'),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          delhiPrice: double.tryParse(value),
                          kolkataPrice: _newProduct.kolkataPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['Bikaner'].toString(),
                      decoration: InputDecoration(labelText: 'Price for Bikaner'),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          bikanerPrice: double.tryParse(value),
                          kolkataPrice: _newProduct.kolkataPrice,
                          delhiPrice: _newProduct.delhiPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['Varanasi'].toString(),
                      decoration: InputDecoration(labelText: 'Price for Varanasi'),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          varanasiPrice: double.tryParse(value),
                          kolkataPrice: _newProduct.kolkataPrice,
                          delhiPrice: _newProduct.delhiPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['Hyderabad'].toString(),
                      decoration: InputDecoration(labelText: 'Price for Hyderabad'),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          hyderabadPrice: double.tryParse(value),
                          kolkataPrice: _newProduct.kolkataPrice,
                          delhiPrice: _newProduct.delhiPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['Kolkata'].toString(),
                      decoration: InputDecoration(labelText: 'Price for Kolkata'),
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          kolkataPrice: double.tryParse(value),
                          delhiPrice: _newProduct.delhiPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
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
                          imageUrl: value,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
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
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: int.tryParse(value),
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        'Discount(in %)',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    TextFormField(
                      initialValue: _initValues['five'].toString(),
                      decoration: InputDecoration(labelText: '5kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: value.isEmpty ? 0 : double.tryParse(value),
                          ten: _newProduct.ten,
                          twenty: _newProduct.twenty,
                          thirty: _newProduct.thirty,
                          fifty: _newProduct.fifty,
                          seventyFive: _newProduct.seventyFive,
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['ten'].toString(),
                      decoration: InputDecoration(labelText: '10kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: value.isEmpty ? 0 : double.tryParse(value),
                          twenty: _newProduct.twenty,
                          thirty: _newProduct.thirty,
                          fifty: _newProduct.fifty,
                          seventyFive: _newProduct.seventyFive,
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['twenty'].toString(),
                      decoration: InputDecoration(labelText: '20kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: _newProduct.ten,
                          twenty: value.isEmpty ? 0 : double.tryParse(value),
                          thirty: _newProduct.thirty,
                          fifty: _newProduct.fifty,
                          seventyFive: _newProduct.seventyFive,
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['thirty'].toString(),
                      decoration: InputDecoration(labelText: '30kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: _newProduct.ten,
                          twenty: _newProduct.twenty,
                          thirty: value.isEmpty ? 0 : double.tryParse(value),
                          fifty: _newProduct.fifty,
                          seventyFive: _newProduct.seventyFive,
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['fifty'].toString(),
                      decoration: InputDecoration(labelText: '50kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: _newProduct.ten,
                          twenty: _newProduct.twenty,
                          thirty: _newProduct.thirty,
                          fifty: value.isEmpty ? 0 : double.tryParse(value),
                          seventyFive: _newProduct.seventyFive,
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['seventyFive'].toString(),
                      decoration: InputDecoration(labelText: '75kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: _newProduct.ten,
                          twenty: _newProduct.twenty,
                          thirty: _newProduct.thirty,
                          fifty: _newProduct.fifty,
                          seventyFive:
                              value.isEmpty ? 0 : double.tryParse(value),
                          hundred: _newProduct.hundred,
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['hundred'].toString(),
                      decoration: InputDecoration(labelText: '100kg'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _newProduct = Product(
                          id: _newProduct.id,
                          title: _newProduct.title,
                          imageUrl: _newProduct.imageUrl,
                          stockAvailable: _newProduct.stockAvailable,
                          category1: _newProduct.category1,
                          isFavourite: _newProduct.isFavourite,
                          description: _newProduct.description,
                          five: _newProduct.five,
                          ten: _newProduct.ten,
                          twenty: _newProduct.twenty,
                          thirty: _newProduct.thirty,
                          fifty: _newProduct.fifty,
                          seventyFive: _newProduct.seventyFive,
                          hundred: value.isEmpty ? 0 : double.tryParse(value),
                          delhiPrice: _newProduct.delhiPrice,
                          hyderabadPrice: _newProduct.hyderabadPrice,
                          bikanerPrice: _newProduct.bikanerPrice,
                          varanasiPrice: _newProduct.varanasiPrice,
                          kolkataPrice: _newProduct.kolkataPrice,
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
