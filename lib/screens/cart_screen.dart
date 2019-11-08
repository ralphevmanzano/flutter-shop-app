import 'package:flutter/material.dart';
import 'package:flutter_shop_app/providers/cart_provider.dart';
import 'package:flutter_shop_app/widgets/cart_item.dart' as ci;
import 'package:flutter_shop_app/widgets/cart_total_card.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          if (i < cart.uniqueItemCount) {
            return ci.CartItem(
              id: cart.items[i].id,
              productId: cart.keys[i],
              title: cart.items[i].title,
              quantity: cart.items[i].quantity,
              price: cart.items[i].price,
              imageUrl: cart.items[i].imageUrl,
            );
          } else {
            return CartTotalCard(
              cartTotalAmount: cart.totalAmount,
              cart: cart,
            );
          }
        },
        itemCount: cart.uniqueItemCount + 1,
      ),
    );
  }
}
