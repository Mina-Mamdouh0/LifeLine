import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Search',style: TextStyle(color: Colors.white),),
            backgroundColor: const Color(0xff078EB2),
          ),
          body:
          
          Column(
            children: [
              SizedBox(height: 10,),
              TextFormField(
                onChanged: (val){
                  if(val.isEmpty){
                    cubit.se();
                  }else{
                  cubit.getSearchProduct(text: val);
                  }

                },
                decoration: InputDecoration(
                  hintText: 'Search for pharmacies or products...',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              (state is LoadingGetAllUser)?
              const Center(child: CircularProgressIndicator(),):Expanded(
                child: ListView.builder(
                  itemCount: cubit.search.length,
                  itemBuilder: (context, index) {
                    final product = cubit.search[index];
                    return ListTile(
                      leading: ClipOval(child: Image.network(product.image??'',height: 60,width: 60,fit: BoxFit.fill,)),
                      title: Text(product.category??''),
                      subtitle: Text('Sales: ${product.discount} EGP'),
                      onTap: () {
                        cubit.addCard(product);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
