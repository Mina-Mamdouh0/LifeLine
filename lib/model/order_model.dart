
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel{
  String ? uid;
  String ? address;
  String ? name;
  String ? uidOwner;
  String ? nameOwner;
  String ? phone;
  String ? price;
  Timestamp ? createdAt;
  String ? idStore;


  OrderModel(
      {this.name,
      this.price,
      this.address,
      this.phone,
      this.createdAt,
      this.uid,
      this.nameOwner,
      this.idStore,
      this.uidOwner});

  factory OrderModel.formJson(json,){
    return OrderModel(
      phone:json['Phone'],
      address: json['Address'],
      uid: json['UId'],
      nameOwner: json['NameOwner'],
      name: json['Name'],
      uidOwner: json['UidOwner'],
      createdAt: json['CreatedAt'],
      price: json['Price'],
      idStore: json['IdStore'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Phone': phone,
      'Address': address,
      'UId': uid,
      'IdStore': idStore,
      'CreatedAt': createdAt,
      'Name': name,
      'NameOwner': nameOwner,
      'Price': price,
      'UidOwner': uidOwner,
      'Price': price,
    };
  }

}