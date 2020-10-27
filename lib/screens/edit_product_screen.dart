import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProducts';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageTextController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isInit = true;
  bool isLoading = false;
  Product editedProduct = Product(
    id: null,
    title: '',
    description: '',
    imageUrl: '',
    price: 0,
    isFavorite: false,
  );
  Map<String, String> initProduct = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        editedProduct =
            Provider.of<ProductsProvider>(context).getItem(productId);
        initProduct = {
          'title': editedProduct.title,
          'price': editedProduct.price.toStringAsFixed(2),
          'description': editedProduct.description,
          'imageUrl': '',
        };
        _imageTextController.text = editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveForm() async {
    final _isValid = formKey.currentState.validate();
    if (!_isValid) {
      return;
    }
    formKey.currentState.save();
    try {
      await Provider.of<ProductsProvider>(context, listen: false)
          .addProductViaAsyncAwait(editedProduct);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error!'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: editedProduct.title.isEmpty
            ? Text('Add Product')
            : Text('Edit Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _saveForm();
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                //for very long forms (or in landscape mode), it is
                //advisable to use SingleChildScrollView with Column
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: initProduct['title'],
                      onSaved: (newValue) {
                        editedProduct = Product(
                          title: newValue,
                          description: editedProduct.description,
                          id: editedProduct.id,
                          price: editedProduct.price,
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title can\'t be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      //is was going to next node without FocusNode() also
                      //but just for reference i am using it
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                    ),
                    TextFormField(
                      initialValue: '${initProduct['price']}',
                      onSaved: (newValue) {
                        editedProduct = Product(
                          title: editedProduct.title,
                          description: editedProduct.description,
                          id: editedProduct.id,
                          price: double.parse(newValue),
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Price can\'t be empty';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please must be greater than 0';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                    ),
                    TextFormField(
                      initialValue: initProduct['description'],
                      onSaved: (newValue) {
                        editedProduct = Product(
                          title: editedProduct.title,
                          description: newValue,
                          id: editedProduct.id,
                          price: editedProduct.price,
                          imageUrl: editedProduct.imageUrl,
                          isFavorite: editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description can\'t be empty';
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            right: 10,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          width: 100,
                          height: 100,
                          child: _imageTextController.text.isEmpty
                              ? Text(
                                  'Enter Image URL',
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : Image.network(
                                  _imageTextController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        //very important to wrap this in expanded
                        Expanded(
                          child: TextFormField(
                            onSaved: (newValue) {
                              editedProduct = Product(
                                title: editedProduct.title,
                                description: editedProduct.description,
                                id: editedProduct.id,
                                price: editedProduct.price,
                                imageUrl: newValue,
                                isFavorite: editedProduct.isFavorite,
                              );
                            },
                            textInputAction: TextInputAction.done,
                            controller: _imageTextController,
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Image URL can\'t be empty';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid Image URL';
                              }
                              if (!value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg') &&
                                  !value.endsWith('.png')) {
                                return 'Please enter a valid Image URL';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              //this forces to rebuild the widget
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
