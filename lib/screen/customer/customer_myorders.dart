import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getCustomerOrders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xff078EB2),
      ),
      body: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return (state is LoadingGetAllUser)?
          const Center(child: CircularProgressIndicator()):ListView.builder(
            itemCount: cubit.orderList.length,
            itemBuilder: (context, index) {
              final order = cubit.orderList[index];
              return ListTile(
                title: Text('Order ID: ${order.uid}'),
                subtitle: Text('Date: ${order.createdAt?.toDate()}'),
                trailing: Text('\$${order.price}'),
              );
            },
          );
        },
      )
    );
  }
}
