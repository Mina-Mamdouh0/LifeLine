import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/screen/store/store_orders.dart';
import 'package:untitled/screen/store/store_product.dart';
import 'package:untitled/screen/store/storeeditpage.dart';
import 'package:untitled/screen/store/storesettings.dart';

class StoreHomePage extends StatelessWidget {
  const StoreHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff078EB2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Image.asset(
            'assets/image/store.png',
            width: 150.0,
            height: 150.0,
          ),
          const SizedBox(height: 20.0),
           Text(
            BlocProvider.of<AppCubit>(context).signUpModel?.name??'',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(18.0),
              children: [
                _buildMenuItem(context, 'Profile Update', Icons.person, () {
                  // Navigate to profile update page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreEditPage()));
                }),
                _buildMenuItem(context, 'Product Update', Icons.cloud_upload,
                        () {
                      // Navigate to product update page
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreProduct()));
                    }),
                _buildMenuItem(
                    context, 'Orders', Icons.local_shipping, () {
                  // Navigate to orders page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreOrdersPage()));
                }),
                _buildMenuItem(context, 'Settings', Icons.settings, () {
                  // Navigate to settings page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreSettings()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.lightBlue,
      child: TextButton(
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48.0, color: Colors.white),
              const SizedBox(height: 12.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
