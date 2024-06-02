import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/screen/Pham/paharmacyproduct.dart';
import 'package:untitled/screen/Pham/pharmacychoose.dart';
import 'package:untitled/screen/Pham/pharmacyprofile.dart';
import 'package:untitled/screen/Pham/pharmacysettings.dart';

class PharmHomePage extends StatefulWidget {
  const PharmHomePage({Key? key}) : super(key: key);

  @override
  State<PharmHomePage> createState() => _PharmHomePageState();
}

class _PharmHomePageState extends State<PharmHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff078EB2),
        elevation: 0,
        title: const Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20.0),
          Image.asset(
            'assets/image/pharmacy.png',
            width: 150.0,
            height: 150.0,
          ),
          const SizedBox(height: 20.0),
          Text(
            BlocProvider.of<AppCubit>(context).signUpModel?.name??'',
            style: const TextStyle(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PharmProfilePage()));
                }),
                _buildMenuItem(context, 'Product Update', Icons.cloud_upload,
                        () {
                      // Navigate to product update page
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PharmProducts()));
                    }),
                _buildMenuItem(
                    context, 'Orders', Icons.local_shipping, () {
                  // Navigate to orders page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PharmChoosePage()));
                }),
                _buildMenuItem(context, 'Settings', Icons.settings, () {
                  // Navigate to settings page
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PharmSettings()));
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
              SizedBox(height: 12.0),
              Text(
                title,
                style: TextStyle(
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
