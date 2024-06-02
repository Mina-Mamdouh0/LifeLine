import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';

class StoreProduct extends StatefulWidget {
  const StoreProduct({Key? key}) : super(key: key);

  @override
  State<StoreProduct> createState() => _StoreProductState();
}

class _StoreProductState extends State<StoreProduct> {

  String ? category;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Product Update',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff078EB2),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select Product Category:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  DropdownButtonFormField<String>(
                    items: <String>[
                      'Medicines',
                      'Medical Tools',
                      'Medical Equipment',
                      'Health Supplements'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        category = newValue;
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Drop Files Here to Add Products:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () async{
                      XFile? picked=await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 1080,maxWidth: 1080);
                      if(picked !=null){
                        cubit.changeImage(img: File(picked.path));
                      }
                    },
                    child: Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: cubit.image!=null?
                      Image.file(cubit.image!,height: 200.0,fit: BoxFit.fill,width: double.infinity,):const Center(
                        child: Icon(
                          Icons.cloud_upload,
                          size: 50.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  (state is LoadingPostStoreState)?
                  const Center(child: CircularProgressIndicator(),)
                      :ElevatedButton(
                    onPressed: () {
                      if(cubit.image!=null && category!=null){
                       cubit.postProduct(category: category!,
                       typeUpload: 'Store');
                      }
                    },

                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff0E4161)),
                    ),
                    child: const Text(
                      'Upload Product',
                      style: TextStyle(
                          color: Colors.white),
                    ),
                  ),


                ],
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessPostStoreState){
            Navigator.pop(context);
          }

        });
  }
}
