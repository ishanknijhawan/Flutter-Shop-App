import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit_outlined),
                onPressed: () => Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                ),
                onPressed: () {
                  final scaffold = Scaffold.of(context);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Container(
                          child: Row(
                            children: [
                              Icon(Icons.delete_forever_outlined),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Delete item ?'),
                            ],
                          ),
                        ),
                        content: Text('Do you want to delete this item ?'),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              Navigator.of(context).pop();
                              try {
                                await productData
                                    .deleteProductUsingAsyncAwait(id);
                              } catch (error) {
                                scaffold.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Delete failed!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
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
