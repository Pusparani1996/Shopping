//import 'dart:html';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodappgridviewbuilder/card_model.dart';
import 'package:foodappgridviewbuilder/cart_provider.dart';
import 'package:foodappgridviewbuilder/database.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = ["Apple", "Green Apple", "Grapes", "Orange"];
  List<String> productUnit = ["Kg", "Dozen", "Kg", "kg"];
  List<int> productPrice = [10, 20, 30, 40];
  List<String> productImage = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6syPu5Njlz_DwJ8q8La6bxfuQzhkhpeJT9w&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5s0nVoF9sDuYWIJwuSrV3vDyoT26pS64Psg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf291uUYgvBIHo-K7QWdeXn-jbiFZqOME5ZQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS3-jC9Iu_zBxPNeFBY6koriThqplo-rTQoQ&usqp=CAU",
  
  ];
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product List"),
          actions: [
            Center(
              child: Row(
                children: [
                  const Padding(
                    padding:  EdgeInsets.only(right: 10),
                    child: Icon(Icons.search),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Badge(
                      badgeContent: Consumer<CartProvider>(
                        builder: (context, value, child) {
                          return  Text(
                          value.getCounter().toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        );
                          
                        },
                      
                      ),
                      animationDuration: const Duration(microseconds: 300),
                      child: const Icon(Icons.shopping_bag_outlined),
                    ),
                  ),
                ],
              ),
            ),
          
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: 
            
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: GridView.builder(
                shrinkWrap: true,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2/3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                      ), 
              itemCount: productName.length,

              itemBuilder: (BuildContext context, index) {
                return Container(
                  //height: 200,
                 // width:400,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                 //color: Colors.amber,
                  borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Image(
                            height: 150,
                            width: 200,
                            image: NetworkImage(productImage[index].toString())),
                              Text(
                                        productName[index].toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                        productUnit[index].toString() +
                                              "" + 
                                              r" $ " +
                                              productPrice[index].toString(),
                                        style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                      ),
                                            ),
                                          Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: (){
                                            dbHelper!.insert(Cart(
                                              id: index, 
                                              productId: index.toString(), 
                                              productName: productName[index].toString(),
                                               initialPrice: productPrice[index], 
                                               productPrice: productPrice[index],
                                                quality: 1, 
                                                unitTag: productUnit[index].toString(), 
                                                image: productImage[index].toString())
                                                ).then((value) {
                                                  cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                                  cart.addCounter();
                                                  print("Product is added");

                                                }).onError((error, stackTrace) {
                                                  print(error.toString());
                                                });
                                          },
                                          child: Container(
                                            width: 100,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                "Add to card",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ),
                                        ),
                                          )
                        ],

                      )
                    ],
                  ),
               
                );
                
              }),
            ),
           )
          ],
         
          
        )
        );
  }
}

