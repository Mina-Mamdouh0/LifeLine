import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/model/profile_model.dart';


class PharmRequestOrdersPage extends StatefulWidget {
  const PharmRequestOrdersPage({super.key});

  @override
  _PharmRequestOrdersPageState createState() => _PharmRequestOrdersPageState();
}

class _PharmRequestOrdersPageState extends State<PharmRequestOrdersPage> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getAllStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff078EB2),
              title: const Text(
                'Request Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: (state is LoadingGetAllUser)?
            const Center(child: CircularProgressIndicator(),)
                :ListView.builder(
              itemCount: cubit.usersDate.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cubit.usersDate[index].name??''),
                  subtitle: Text(cubit.usersDate[index].address??''),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreDetailsPage(store: cubit.usersDate[index]),
                      ),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}

class StoreDetailsPage extends StatefulWidget {
  final SignUpModel store;

  const StoreDetailsPage({super.key, required this.store});

  @override
  State<StoreDetailsPage> createState() => _StoreDetailsPageState();
}

class _StoreDetailsPageState extends State<StoreDetailsPage> {

  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getStoreProduct(idStore: widget.store.uId??'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff078EB2),
              title: Text(
                widget.store.name??'',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: (state is LoadingPostStoreState)?
                  const Center(child: CircularProgressIndicator(),):ListView.builder(
                     itemCount: cubit.productStoreList.length,
                      itemBuilder: (context,index){
                        return _buildCategoryItem(context, cubit.productStoreList[index].category??'',
                        (){
                          cubit.createOrder(category: cubit.productStoreList[index].category??'', price: cubit.productStoreList[index].price??'',
                          idStore: cubit.productStoreList[index].uidStore??'');
                        });
                      }),
                ),
              ],
            ),
          );
        },
        listener: (context,state){
          if(state is SuccessPostStoreState){

            Navigator.pop(context);

          }


        });
  }

  Widget _buildCategoryItem(BuildContext context, String categoryName,Function() fct) {
    return ListTile(
      title: Text(categoryName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: fct,
          ),
        ],
      ),
    );
  }
}
