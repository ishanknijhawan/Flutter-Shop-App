import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../data/product_list.dart';
import '../models/http_exception.dart';

class ProductsProvider with ChangeNotifier {
  //List<Product> _items = ProductList.productList;
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<void> getProducts() async {
    const url = 'https://boycottchina-b2cc6.firebaseio.com/products.json';
    final response = await http.get(url);
    var extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Product> loadedProducts = [];
    extractedData.forEach((id, product) {
      loadedProducts.add(
        Product(
            id: id,
            title: product['title'],
            isFavorite: product['isFavorite'],
            description: product['description'],
            imageUrl: product['imageUrl'],
            price: product['price']),
      );
    });
    _items = loadedProducts;
    print('items are $items');
    notifyListeners();
  }

  //https://assets.entrepreneur.com/content/3x2/2000/20191219170611-GettyImages-1152794789.jpeg
  Future<void> addProduct(Product product) {
    const url = 'https://boycottchina-b2cc6.firebaseio.com/products.json';
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'id': product.id,
          'isFavorite': product.isFavorite,
          'price': product.price,
          'description': product.description,
          'imageUrl': product.imageUrl,
        },
      ),
    )
        .then((value) {
      if (product.id == null) {
        var newProduct = Product(
            id: json.decode(value.body)['name'],
            title: product.title,
            price: product.price,
            description: product.description,
            imageUrl: product.imageUrl,
            isFavorite: false);
        _items.insert(0, newProduct);
      } else {
        final index = _items.indexWhere((element) => element.id == product.id);
        _items[index] = product;
      }
      notifyListeners();
    }).catchError((error) => throw (error));
  }

  //similar to addProduct but with async await
  Future<void> addProductViaAsyncAwait(Product product) async {
    try {
      const url = 'https://boycottchina-b2cc6.firebaseio.com/products.json';
      if (product.id == null) {
        final response = await http.post(
          url,
          body: json.encode(
            {
              'title': product.title,
              'id': product.id,
              'isFavorite': product.isFavorite,
              'price': product.price,
              'description': product.description,
              'imageUrl': product.imageUrl,
            },
          ),
        );

        print('response is ${response.body}');

        var newProduct = Product(
            id: json.decode(response.body)['name'],
            title: product.title,
            price: product.price,
            description: product.description,
            imageUrl: product.imageUrl,
            isFavorite: false);
        _items.insert(0, newProduct);
      } else {
        final url =
            'https://boycottchina-b2cc6.firebaseio.com/products/${product.id}.json';
        await http.patch(
          url,
          body: json.encode(
            {
              'title': product.title,
              'id': product.id,
              'isFavorite': product.isFavorite,
              'price': product.price,
              'description': product.description,
              'imageUrl': product.imageUrl,
            },
          ),
        );

        final index = _items.indexWhere((element) => element.id == product.id);
        _items[index] = product;
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void deleteProduct(String id) {
    final url = 'https://boycottchina-b2cc6.firebaseio.com/products/$id.json';
    var existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];

    http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not be deleted!');
      }
      existingProductIndex = null;
      existingProduct = null;
    }).catchError((_) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    });
    _items.removeWhere((element) => element.id == id);

    notifyListeners();
  }

  Future<void> deleteProductUsingAsyncAwait(String id) async {
    var existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];

    _items.removeWhere((element) => element.id == id);
    notifyListeners();

    final url = 'https://boycottchina-b2cc6.firebaseio.com/products/$id.json';

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not be deleted!');
    }
    existingProductIndex = null;
    existingProduct = null;
  }

  List<Product> get showFavorites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product getItem(String id) {
    return _items.firstWhere(
      (element) => element.id == id,
    );
  }
}
