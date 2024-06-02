import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/customer/customerhomepage.dart';
import 'package:untitled/screen/Pham/pharmacyhome.dart';
import 'package:untitled/screen/auth/second_page.dart';
import 'package:untitled/screen/store/storehomepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3),
            () async{
          if(FirebaseAuth.instance.currentUser?.uid!=null){
            BlocProvider.of<AppCubit>(context).getDateUser();
          }else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return const SignupPage();
            }));
          }
        }
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xff078EB2), Color(0xff0E4161)],
                    stops: [0.4, 0.6],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'HELLO!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/image/my_logo.png'),
                      ),
                      SizedBox(
                        height: 500,
                        width: 500,
                        child: Image.asset('assets/image/home.png'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessGetUserState){
            if((BlocProvider.of<AppCubit>(context).signUpModel?.type??'') == 'Store'){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return const StoreHomePage();
              }));
            }else if(((BlocProvider.of<AppCubit>(context).signUpModel?.type??'') == 'Pharm')){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return const PharmHomePage();
              }));
            }
            else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                return const CustomerHomePage();
              }));
            }
          }

        });
  }
}

