import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/customer/customercheckoutpage.dart';
import 'package:untitled/screen/customer/customerhomepage.dart';

class MyCartPage extends StatelessWidget {
  const MyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Cart', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color(0xff078EB2),
          ),
          body: ListView.builder(
            itemCount: AppCubit.get(context).cardList.length,
            itemBuilder: (context, index) {
              final product = AppCubit.get(context).cardList[index];
              return ListTile(
                leading: ClipOval(child: Image.network(product.image??'',height: 60,width: 60,fit: BoxFit.fill,)),
                title: Text(product.category??''),
                subtitle: Text('\$${product.price??''}'),
                trailing: InkWell(
                  onTap: (){
                    AppCubit.get(context).removeCard(product);
                  },
                    child: const Icon(Icons.remove)),
              );
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckoutPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff078EB2), // Set the background color of the elevated button
                ),
                child: const Text('Checkout',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),
        );
      },
    );
  }
}

