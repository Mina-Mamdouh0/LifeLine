import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/Pham/pharmacyhome.dart';
import 'package:untitled/screen/auth/forgetpassword_page.dart';
import 'package:untitled/screen/customer/customerhomepage.dart';
import 'package:untitled/screen/store/storehomepage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> kForm =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff078EB2), Color(0xff0E4161)],
                  stops: [0.4, 0.6],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: kForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset('assets/image/my_logo.png', height: 200, width: 200),
                      const SizedBox(height: 20.0),


                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.white),
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter Data';
                          }
                        },
                        decoration:  InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.red
                                )
                            )
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter Data';
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white
                                )
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),

                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.white
                                )
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.red
                                )
                            )
                        ),
                      ),


                      const SizedBox(height: 30.0),
                      (state is LoadingLoginState)?
                      const Center(child: CircularProgressIndicator(),)
                          :ElevatedButton(
                        onPressed: () {
                          if(kForm.currentState!.validate()){
                            cubit.userLogin(email: emailController.text, password: passwordController.text);
                          }
                            },
                        child: const Text('Sign in'),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ForgetPage()),
                          );
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return const StoreHomePage();
              }),(route) => false,);
            }else if(((BlocProvider.of<AppCubit>(context).signUpModel?.type??'') == 'Pharm')){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return const PharmHomePage();
              }),(route) => false,);
            }
            else{
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                return const CustomerHomePage();
              }),(route) => false,);
            }
          }

        });
  }

}
