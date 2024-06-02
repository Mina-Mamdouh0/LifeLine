import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';

class MostSalesProductsPage extends StatefulWidget {
  const MostSalesProductsPage({Key? key}) : super(key: key);

  @override
  State<MostSalesProductsPage> createState() => _MostSalesProductsPageState();
}

class _MostSalesProductsPageState extends State<MostSalesProductsPage> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getPrhmProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Most Sales Products',style: TextStyle(color: Colors.white),),
            backgroundColor: Color(0xff078EB2),
          ),
          body: (state is LoadingGetAllUser)?
          const Center(child: CircularProgressIndicator(),):ListView.builder(
            itemCount: cubit.productPrhmList.length,
            itemBuilder: (context, index) {
              final product = cubit.productPrhmList[index];
              return ListTile(
                leading: ClipOval(child: Image.network(product.image??'',height: 60,width: 60,fit: BoxFit.fill,)),
                title: Text(product.category??''),
                subtitle: Text('Sales: ${product.price} EGP'),
                onTap: () {
                  cubit.addCard(product);
                },
              );
            },
          ),
        );
      },
    );
  }
}

