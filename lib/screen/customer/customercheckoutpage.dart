import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/customer/customerhomepage.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  bool _isCreditCardSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          title: Text('Checkout', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xff078EB2),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items in Cart:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                  SizedBox(height: 20),
                  Text(
                    'Total Price: \$${AppCubit.get(context).prCard.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter your information:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Set the border radius
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Set the border radius
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Set the border radius
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Select Payment Method:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text('Cash'),
                          leading: Radio(
                            value: false,
                            groupValue: _isCreditCardSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                _isCreditCardSelected = false;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text('Credit Card'),
                          leading: Radio(
                            value: true,
                            groupValue: _isCreditCardSelected,
                            onChanged: (bool? value) {
                              setState(() {
                                _isCreditCardSelected = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_isCreditCardSelected) ...[
                    SizedBox(height: 20),
                    Text(
                      'Enter Credit Card Details:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Expiration Date',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'CVV',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],

                  SizedBox(height: 20),
                  (state is LoadingPostStoreState)?
                  const Center(child: CircularProgressIndicator()):ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        AppCubit.get(context).createOrder(
                            category: AppCubit.get(context).cardList[0].category??'',
                            price: AppCubit.get(context).prCard,
                            idStore: AppCubit.get(context).cardList[0].uidStore??'',
                          phone: _phoneController.text,
                          address: _addressController.text,
                          nameOwner: _nameController.text,
                        );
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff078EB2), // Set the background color of the elevated button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Set the button border radius
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Text(
                        'Confirm Checkout',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
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
          if(state is SuccessPostStoreState){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return CustomerHomePage();
            }), (route) => false);
          }
      },
      );
  }
}

