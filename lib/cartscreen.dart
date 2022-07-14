import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodappgridviewbuilder/cart_provider.dart';
import 'package:provider/provider.dart';

import 'card_model.dart';

class CartScreen extends StatefulWidget{
  const CartScreen({Key? key}) : super(key: key);
  
  @override
  _CartScreenState createState()=> _CartScreenState();
  
}



class _CartScreenState extends State<CartScreen>{
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
       appBar: AppBar(
          title: const Text("My Cart"),
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
            FutureBuilder(
              future: cart.getData(),
              builder: (context,AsyncSnapshot<List<Cart>>snapshot){
                if(snapshot.hasData){
                  return Expanded(
                    child: GridView.builder(
                shrinkWrap: true,
              gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2/3,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                      ), 
              itemCount: snapshot.data!.length,

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
                            image: NetworkImage(snapshot.data![index].image.toString())
                            ),
                              Text(
                                        snapshot.data![index].productName.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                            Padding(
                                              padding: const EdgeInsets.all(3.0),
                                              child: Text(
                                        // ignore: prefer_interpolation_to_compose_strings
                                       snapshot.data![index].unitTag.toString()+
                                              "" + 
                                              r" $ " +
                                              snapshot.data![index].productPrice.toString(),
                                        style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                      ),
                                            ),
                                          Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: (){
                                        
                            
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
                    );
                }
                return Text("");

              }
            )
          ],
        ),
    );
  }
}
