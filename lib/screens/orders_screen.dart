import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              // Handle error
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderProvider, _) => ListView.builder(
                  itemBuilder: (ctx, i) => OrderItem(
                    order: orderProvider.orders[i],
                  ),
                  itemCount: orderProvider.orders.length,
                ),
              );
            }
          }
          return Container();
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
