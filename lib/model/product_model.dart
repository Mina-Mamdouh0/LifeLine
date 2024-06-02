
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel{
  String? uidStore;
  String? nameStore;
  String? addressStore;
  String? phoneStore;
  String? category;
  String? image;
  String? uid;
  Timestamp? createAt;
  String? price;
  String? discount;
  String? typeUpload;

  ProductModel(
      {this.category,
        this.addressStore,
        this.uid,
        this.image,
        this.phoneStore,
        this.nameStore,
        this.createAt,
        this.price,
        this.discount,
        this.typeUpload,
        this.uidStore});

  factory ProductModel.formJson(json,){
    return ProductModel(
      discount: json['Discount'],
      phoneStore:json['PhoneStore'],
      addressStore: json['AddressStore'],
      uid: json['UId'],
      uidStore: json['UidStore'],
      nameStore: json['NameStore'],
      createAt: json['CreatedAt'],
      image: json['Image'],
      category: json['Category'],
      price: json['Price'],
      typeUpload: json['TypeUpload'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Category': category,
      'AddressStore': addressStore,
      'UId': uid,
      'CreatedAt': createAt,
      'Image': image,
      'PhoneStore': phoneStore,
      'UidStore': uidStore,
      'NameStore': nameStore,
      'Discount': discount,
      'Price': price,
      'TypeUpload': typeUpload,
    };
  }
}