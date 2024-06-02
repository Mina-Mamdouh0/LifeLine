import 'package:flutter/material.dart';

class MyWishlistPage extends StatelessWidget {
  const MyWishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with actual data fetching logic
    final List<Product> wishlist = [
      Product(name: 'Product 1', price: 20.0),
      Product(name: 'Product 2', price: 30.0),
      Product(name: 'Product 3', price: 40.0),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff078EB2),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            // Add more details or actions if needed
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}
