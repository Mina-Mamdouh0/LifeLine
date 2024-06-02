import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';

class NearestPharmaciesPage extends StatefulWidget {
  const NearestPharmaciesPage({super.key});

  @override
  _NearestPharmaciesPageState createState() => _NearestPharmaciesPageState();
}

class _NearestPharmaciesPageState extends State<NearestPharmaciesPage> {

  @override
  void initState() {
BlocProvider.of<AppCubit>(context).getAllPham();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearest Pharmacies'),
      ),
      body: BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return ListView.builder(
            itemCount: cubit.usersDate.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cubit.usersDate[index].name??''),
              );
            },
          );
        },
      ),
    );
  }
}
