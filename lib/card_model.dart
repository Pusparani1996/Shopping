import 'dart:core';


class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? initialPrice;
  final int? productPrice;
  final int? quality;
  final String? unitTag;
  final String? image;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.initialPrice,
    required this.productPrice,
    required this.quality,
    required this.unitTag,
    required this.image,
  });
  Cart.fromMap(Map<dynamic ,dynamic>res )
  
  : id = res["id"],
  productId =res["productId"],
  productName = res ["productName"],
  initialPrice = res ["initialPrice"],
  productPrice = res ["productPrice"],
  quality = res ["quality"],
  unitTag = res ["unitTag"],
  image = res ["image"] ;

  Map<String,Object?> toMap(){
return{
 "  id" :id,
  "productId" :productId,
 " productName" : productName,
  "initialPrice" :initialPrice,
  "productPrice" :productPrice,
  "quality ":quality,
"  unitTag" :unitTag,
 " image ":image ,
};
  }
}
