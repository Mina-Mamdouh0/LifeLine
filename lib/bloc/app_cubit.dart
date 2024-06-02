
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/model/order_model.dart';
import 'package:untitled/model/product_model.dart';
import 'package:untitled/model/profile_model.dart';
import 'package:untitled/model/store_model.dart';
import 'package:uuid/uuid.dart';

class AppCubit extends Cubit<AppState>{
  AppCubit() : super(InitialState());

  static AppCubit get(context)=>BlocProvider.of(context);


  void userLogin({required String email, required String password,}){
    emit(LoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).
    then((value){
      emit(SuccessLoginState());
      getDateUser();
    }).
    onError((error,_){
      emit(ErrorLoginState());
    });
  }

  void signUp({required String email, required String password, required String name, required String address,required String type}){
    emit(LoadingSignUpState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value){
      SignUpModel model=SignUpModel(name: name, email: email, address: address, uId: value.user?.uid,
          image: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
          createdAt: Timestamp.now(),
          type: type,
          phone: ''
      );
      FirebaseFirestore.instance.collection('Users').doc(value.user?.uid).set(
          model.toMap()
      ).then((value){
        emit(SuccessSignUpState());
        getDateUser();
      }).onError((error,_){
        emit(ErrorSignUpState());
      });
    }).onError((error,_){
      emit(ErrorSignUpState());
    });
  }

  SignUpModel? signUpModel;
  void getDateUser(){
    emit(LoadingGetUserState());
    signUpModel=null;
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).
      get().
      then((value){
        signUpModel=SignUpModel.formJson(value.data()!);
        emit(SuccessGetUserState());
      }).onError((error,_){
        emit(ErrorGetUserState());
      });
    }
  }

  void logout(){
    FirebaseAuth.instance.signOut().whenComplete((){
      emit(LogoutState());
    });
  }

  void getEditUser({required String phone , required String address,required String name}){
    emit(LoadingEditUserState());
    if(FirebaseAuth.instance.currentUser!=null){
      FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).
      update({
        'Phone':phone,
        'Address':address,
        'Name':name,
      }).
      then((value){
        emit(SuccessEditUserState());
        getDateUser();
      }).onError((error,_){
        emit(ErrorEditUserState());
      });
    }
  }



  File? image;
  String ? url;

  void changeImage({required File img,}){
    image=img;
    emit(ChangeImage());
  }
  void postProduct({required String category,required String typeUpload, String? price, String? dis})async{
    emit(LoadingPostStoreState());
    String uId=const Uuid().v4();

    final ref= FirebaseStorage.instance.ref().child('Products').
    child(FirebaseAuth.instance.currentUser?.uid??'').
    child('$category$uId.jpg');
    await ref.putFile(image!).then((p0)async {
      url =await ref.getDownloadURL();
      ProductModel model=ProductModel(
          image: url!,
          createAt: Timestamp.now(),
          price: price??'',
          category: category,
          nameStore: signUpModel?.name??'',
          addressStore: signUpModel?.address??'',
          uid:uId,
          typeUpload: typeUpload,
          uidStore: signUpModel?.uId??'',
          phoneStore: signUpModel?.phone??'',
          discount: dis??'',
      );
      FirebaseFirestore.instance.collection('Products').doc(uId).
      set(model.toMap())
          .then((value){
        image=null;
        url=null;
        emit(SuccessPostStoreState());
      });
    }).onError((error,_){
      emit(ErrorPostStoreState());
    });
  }


  List<SignUpModel> usersDate=[];
  void getAllStore(){
    emit(LoadingGetAllUser());
    usersDate=[];
    FirebaseFirestore.instance
        .collection('Users').where('Type',isEqualTo: 'Store').get().
    then((value){
      for (var element in value.docs) {
        SignUpModel? s = SignUpModel.formJson(element);
        if(s.uId != FirebaseAuth.instance.currentUser?.uid){
          usersDate.add(SignUpModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  void getAllPham(){
    emit(LoadingGetAllUser());
    usersDate=[];
    FirebaseFirestore.instance
        .collection('Users').where('Type',isEqualTo: 'Pharm').get().
    then((value){
      for (var element in value.docs) {
        SignUpModel? s = SignUpModel.formJson(element);
        if(s.uId != FirebaseAuth.instance.currentUser?.uid){
          usersDate.add(SignUpModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  List<ProductModel> productStoreList=[];
  void getStoreProduct({required String idStore}){
    emit(LoadingGetAllUser());
    productStoreList=[];
    FirebaseFirestore.instance
        .collection('Products').get().
    then((value){
      for (var element in value.docs) {
        ProductModel p = ProductModel.formJson(element.data());
        if(p.uidStore == idStore){
          productStoreList.add(ProductModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  List<ProductModel> productPrhmList=[];
  void getPrhmProduct(){
    emit(LoadingGetAllUser());
    productPrhmList=[];
    FirebaseFirestore.instance
        .collection('Products').where('TypeUpload',isEqualTo: 'Pharm')
        .get().
    then((value){
      for (var element in value.docs) {
          productPrhmList.add(ProductModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  void getOfferProduct(){
    emit(LoadingGetAllUser());
    productPrhmList=[];
    FirebaseFirestore.instance
        .collection('Products').where('TypeUpload',isEqualTo: 'Pharm')
        .get().
    then((value){
      for (var element in value.docs) {
        ProductModel p = ProductModel.formJson(element);
        if((p.discount??'') != ''){
          productPrhmList.add(ProductModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }


  List<ProductModel> cardList=[];
  void addCard(ProductModel p){
    cardList.add(p);
    emit(ErrorGetAllUser());
  }

  void removeCard(ProductModel p){
    cardList.remove(p);
    emit(ErrorGetAllUser());
  }
  
  get  prCard{
    double p =0;
    for (var element in cardList) {
      p+=double.parse(element.price??'');
    }
    return p;
    
  }

  void createOrder({required String category,required String price,required String idStore ,
    String? nameOwner , String? phone , String? address})async{
    emit(LoadingPostStoreState());
    String uId=const Uuid().v4();
    OrderModel model=OrderModel(
      createdAt: Timestamp.now(),
      price: price,
      name: category,
      uidOwner: FirebaseAuth.instance.currentUser?.uid,
      uid:uId,
      nameOwner: nameOwner??signUpModel?.name??'',
      idStore: idStore,
      address: address??signUpModel?.address??'',
      phone: phone??signUpModel?.phone??'',
    );
    FirebaseFirestore.instance.collection('Orders').doc(uId).
    set(model.toMap())
        .then((value){
      emit(SuccessPostStoreState());
    }).onError((error, stackTrace){
      emit(ErrorPostStoreState());
    });
  }

  List<OrderModel> orderList=[];
  void getOrders(){
    emit(LoadingGetAllUser());
    orderList=[];
    FirebaseFirestore.instance.collection('Orders').
    where('IdStore', isEqualTo: FirebaseAuth.instance.currentUser?.uid ).get().
    then((value){
      for (var element in value.docs) {
          orderList.add(OrderModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }

  void getCustomerOrders(){
    emit(LoadingGetAllUser());
    orderList=[];
    FirebaseFirestore.instance.collection('Orders').
    where('UidOwner', isEqualTo: FirebaseAuth.instance.currentUser?.uid ).get().
    then((value){
      for (var element in value.docs) {
        orderList.add(OrderModel.formJson(element.data()));
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }


  List<ProductModel> search=[];

  void se(){
    search=[];
    emit(InitialState());
  }
  void getSearchProduct({required String text}){
    emit(LoadingGetAllUser());
    search=[];
    FirebaseFirestore.instance
        .collection('Products').where('TypeUpload',isEqualTo: 'Pharm')
        .get().
    then((value){
      for (var element in value.docs) {
        ProductModel p = ProductModel.formJson(element);
        if(p.category?.contains(text)??false){
          search.add(ProductModel.formJson(element.data()));
        }
      }
      emit(SuccessGetAllUser());
    }).onError((error,_){
      emit(ErrorGetAllUser());
    });
  }


}