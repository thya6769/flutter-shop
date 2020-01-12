import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/product.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:flutter_complete_guide/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static final String routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descFocusNode = FocusNode();
  final _imageURLFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _product =
      Product(id: null, title: '', price: 0.0, imageUrl: '', description: '');
  var _initialValues = {
    'id': null,
    'title': '',
    'description': '',
    'price': '',
    // TODO: just for spaceholder
    'imageUrl':
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  };

  @override
  void dispose() {
    // clear up the memory.
    _priceFocusNode.dispose();
    _descFocusNode.dispose();
    _imageURLFocusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _product = Provider.of<Products>(context).findById(productId);
        _initialValues = {
          'id': _product.id,
          'title': _product.title,
          'description': _product.description,
          'price': _product.price.toString(),
          'imageUrl': _product.imageUrl,
        };
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();

    final products = Provider.of<Products>(context, listen: false);
    if (_product.id == null) {
      products.addProduct(_product);
    } else {
      products.updateProduct(_product.id, _product);
    }

    Navigator.of(context).pushNamed(UserProductsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          // Use SingleChildScrollView(
          //        child: Column(
          //            children: [ ... ],
          //        ),
          //    ),
          //    if the list is longer the screen height, so that user input is not lost.
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initialValues['title'],
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Title cannot be empty';
                  }

                  return null;
                },
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _product = new Product(
                      id: _product.id,
                      title: value,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initialValues['price'],
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Price cannot be empty';
                  }

                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }

                  if (double.parse(value) <= 0.0) {
                    return 'Price cannot be negative!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _product = new Product(
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(value),
                      imageUrl: _product.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initialValues['description'],
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_imageURLFocusNode);
                },
                onSaved: (value) {
                  _product = new Product(
                      id: _product.id,
                      title: _product.title,
                      description: value,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initialValues['imageUrl'],
                decoration: InputDecoration(labelText: 'Image URL'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.url,
                focusNode: _imageURLFocusNode,
                onFieldSubmitted: (_) {
                  _saveForm();
                },
                onSaved: (value) {
                  _product = new Product(
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
