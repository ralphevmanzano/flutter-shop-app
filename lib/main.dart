import 'package:flutter/material.dart';
import 'package:flutter_shop_app/constants/routes.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';
import 'package:flutter_shop_app/screens/edit_product_screen.dart';
import 'package:flutter_shop_app/screens/orders_screen.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import 'providers/orders_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato'),
        initialRoute: Routes.PRODUCT_OVERVIEW_SCREEN,
        routes: {
          Routes.PRODUCT_OVERVIEW_SCREEN: (_) => ProductsOverviewScreen(),
          Routes.PRODUCT_DETAIL_SCREEN: (_) => ProductDetailScreen(),
          Routes.CART_SCREEN: (_) => CartScreen(),
          Routes.ORDERS_SCREEN: (_) => OrdersScreen(),
          Routes.USER_PRODUCTS_SCREEN: (_) => UserProductScreen(),
          Routes.EDIT_PRODUCT_SCREEN: (_) => EditProductScreen(),
        },
      ),
    );
  }
}
