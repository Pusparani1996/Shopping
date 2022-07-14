import 'package:flutter/material.dart';
import 'package:foodappgridviewbuilder/cart_provider.dart';
import 'package:foodappgridviewbuilder/product_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FoodApp());
}

class FoodApp extends StatelessWidget {
  const FoodApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> CartProvider(),
      child: Builder(builder: (BuildContext context){
          return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
      
    );

      })
    );
  
  }
}
