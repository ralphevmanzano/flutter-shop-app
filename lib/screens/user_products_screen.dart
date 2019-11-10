import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/routes.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }
  
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.EDIT_PRODUCT_SCREEN);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Consumer<Products>(
          builder: (ctx, products, child) => Padding(
            padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemBuilder: (_, i) {
                return Column(
                  children: <Widget>[
                    UserProductItem(
                      id: productData.items[i].id,
                      title: productData.items[i].title,
                      imageUrl: productData.items[i].imageUrl,
                    ),
                  ],
                );
              },
              itemCount: products.items.length,
            ),
          ),
        ),
      ),
    );
  }
}
