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
            OrderButton(
              cartTotalAmount: cartTotalAmount,
              cart: cart,
            )
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartTotalAmount,
    @required this.cart,
  }) : super(key: key);

  final double cartTotalAmount;
  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Checkout'),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cartTotalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<Orders>(
                  context,
                  listen: false,
                ).addOrder(
                  widget.cart.items,
                  widget.cart.totalAmount,
                );
                widget.cart.clear();
              } catch (_) {
                scaffold.hideCurrentSnackBar();
                scaffold.showSnackBar(
                  SnackBar(
                    content: Text(
                      'Error checkout',
                      textAlign: TextAlign.center,
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              } finally {
                _isLoading = false;
              }
            },
    );
  }
}
