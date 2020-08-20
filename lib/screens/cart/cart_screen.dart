import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/common/price_card.dart';
import 'package:loja_virtual_pro/models/cart_manager.dart';
import 'package:loja_virtual_pro/screens/cart/components/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          return ListView(
            children: <Widget>[
              Column(
                children: cartManager.items
                    .map((cartProduct) => CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard(
                onPressed: cartManager.isCartValid ? (){}
                : null,
                buttonText: 'Continuar para Entrega',
              ),
            ],
          );
        },
      ),
    );
  }
}
