import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screen/Pham/pharmacyhome.dart';
import 'package:untitled/screen/auth/signin_page.dart';
import 'package:untitled/screen/store/storehomepage.dart';

import '../../bloc/app_cubit.dart';
import '../../bloc/app_state.dart';

class PharmProfilePage extends StatefulWidget {
  const PharmProfilePage({Key? key}) : super(key: key);

  @override
  State<PharmProfilePage> createState() => _PharmProfilePageState();
}


class _PharmProfilePageState extends State<PharmProfilePage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> kForm= GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = BlocProvider.of<AppCubit>(context).signUpModel?.email??'';
    idController.text = BlocProvider.of<AppCubit>(context).signUpModel?.uId??'';
    nameController.text = BlocProvider.of<AppCubit>(context).signUpModel?.name??'';
    addressController.text = BlocProvider.of<AppCubit>(context).signUpModel?.address??'';
    phoneController.text = BlocProvider.of<AppCubit>(context).signUpModel?.phone??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor:
              const Color(0xff078EB2), // Same color as the container's gradient
              elevation: 0, // No shadow
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back when the back button is pressed
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: kForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/pharmacy.png'),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        enabled: false,
                        controller: emailController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: idController,
                        enabled: false,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Pharmacy ID',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Store Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: addressController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: phoneController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Phone',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),                ),
                    ),
                    const SizedBox(height: 30),
                    (state is LoadingEditUserState)?
                    const Center(child: CircularProgressIndicator(),)
                        :ElevatedButton(
                      onPressed: () {
                        if(kForm.currentState!.validate()){
                          AppCubit.get(context).getEditUser(
                              phone: phoneController.text,
                              address: addressController.text,
                              name: nameController.text);
                        }
                      },

                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(const Color(0xff0E4161)),
                      ),
                      child: const Text(
                        'Save Profile',
                        style: TextStyle(
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessEditUserState){
            Navigator.pop(context);
          }

        });
  }
}
