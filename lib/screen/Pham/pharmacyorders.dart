import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/app_cubit.dart';

class PharmOrdersPage extends StatefulWidget {
  const PharmOrdersPage({Key? key}) : super(key: key);

  @override
  State<PharmOrdersPage> createState() => _PharmOrdersPageState();
}

class _PharmOrdersPageState extends State<PharmOrdersPage> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getOrders();
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(
                  context); // Navigate back when the back button is pressed
            },
          ),
          title: const Text(
            'Orders',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              (state is LoadingGetAllUser)?
              const Center(child: CircularProgressIndicator()):
              ListView.builder(
                  itemCount: cubit.orderList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (c,i){
                    return ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cubit.orderList[i].name??'',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async{
                              try{
                                await launch(cubit.orderList[i].address??'');
                              }catch(e){
                                debugPrint(e.toString());
                              }
                            },
                            child: const Text('Track Orders'),
                          ),
                        ],
                      ),
                      children: [
                        Card(
                          elevation: 3.0,
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ListTile(
                            title: Text(
                              cubit.orderList[i].uid??'',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.0),
                                Text(
                                  'Customer: ${cubit.orderList[i].nameOwner??''}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  'Phone: ${cubit.orderList[i].phone??''}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                            },
                          ),
                        )
                      ],
                    );
                  }),
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.0),
                    child: Image.asset(
                      'assets/image/icon8.png',
                      width: 300.0,
                      height: 300.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
