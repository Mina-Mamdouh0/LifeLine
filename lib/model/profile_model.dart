import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpModel{
  String? name;
  String? email;
  String? address;
  String? uId;
  String? image;
  Timestamp? createdAt;
  String? type;
  String? phone;



  SignUpModel({ this.name, this.email, this.address, this.uId,this.image,this.createdAt,this.type ,this.phone});

  factory SignUpModel.formJson(json,){
    return SignUpModel(
      name: json['Name'],
      email:json['Email'],
      address: json['Address'],
      uId: json['Id'],
      type: json['Type'],
      createdAt: json['CreatedAt'],
      image: json['Image'],
      phone: json['Phone'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'Name': name,
      'Email':email,
      'Address': address,
      'Id': uId,
      'Phone': phone,
      'Type': type,
      'CreatedAt': createdAt,
      'Image': image,
    };
  }
}