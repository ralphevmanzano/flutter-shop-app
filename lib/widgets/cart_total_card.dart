import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/providers/orders_provider.dart';
import 'package:provider/provider.dart';

class CartTotalCard extends StatelessWidget {
  final double cartTotalAmount;
  final Cart cart;

  const CartTotalCard({
    Key key,
    @required this.cartTotalAmount,
    @required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Spacer(),
            Chip(
              label: Text(
                '\$${cartTotalAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.title.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            FlatButton(
              child: Text('Checkout'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Provider.of<Orders>(
                  context,
                  listen: false,
                ).addOrder(
                  cart.items,
                  cart.totalAmount,
                );
                cart.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
