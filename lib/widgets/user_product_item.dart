import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/routes.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  
  const UserProductItem({
    Key key,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      contentPadding: EdgeInsets.only(
        left: 8,
        top: 0,
        right: 0,
        bottom: 0,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.EDIT_PRODUCT_SCREEN, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme
                  .of(context)
                  .errorColor,
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
