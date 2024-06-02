import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/auth/signin_page.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NewAccount extends StatefulWidget {
  const NewAccount({super.key});

  @override
  NewAccountState createState() => NewAccountState();
}

class NewAccountState extends State<NewAccount> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> kForm= GlobalKey<FormState>();

  String ? type;
  List<String> list= ['Store','Pharm','Customer'];

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
                      Image.asset('assets/image/my_logo.png', height: 150, width: 150),
                      const Text(
                        'New Account',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40.0),
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
                        controller: nameController,
                        style: const TextStyle(color: Colors.white),
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter Data';
                          }
                        },
                        decoration:  InputDecoration(
                            hintText: 'Name',
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
                        controller: addressController,
                        style: const TextStyle(color: Colors.white),
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter Data';
                          }
                        },
                        decoration:  InputDecoration(
                            hintText: 'Address',
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
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !_isPasswordVisible,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Please Enter Data';
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            hintText: 'Confirm Password',
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
                      DropdownButtonFormField(
                        value: type,
                        items: [
                          ...list.map((e){
                            return DropdownMenuItem(value: e,child: Text(e,style: TextStyle(color: Colors.black)),);
                          })
                        ],
                        onChanged: (val){
                          type = val;
                        },
                        validator: (val){
                          if(val==null){
                            return 'Please Enter Data';
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                            hintText: 'Type Account',
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

                      const SizedBox(height: 20.0),
                      (state is LoadingSignUpState)?
                      const CircularProgressIndicator(backgroundColor: Colors.white,)
                          :ElevatedButton(
                        onPressed: () {
                          if(kForm.currentState!.validate()){
                            if(passwordController.text == confirmPasswordController.text){
                              cubit.signUp(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  address: addressController.text,
                                  type: type!);
                            }else{
                              Fluttertoast.showToast(
                                msg: 'Password Not Matched',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18.0,
                              );
                            }
                          }
                        },
                        child: const Text('Sign up'),
                      ),
                      const SizedBox(height: 60.0),
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height:
                      20),
                      ElevatedButton(
                        onPressed: () {
                          // Add your account creation logic here
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignInPage()));
                        },
                        child: const Text('Sign in'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessSignUpState){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
              return const SignInPage();
            }));
          }
          else if (state is ErrorSignUpState){
            Fluttertoast.showToast(
              msg: 'Check in information',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0,
            );
          }


        });
  }

}
