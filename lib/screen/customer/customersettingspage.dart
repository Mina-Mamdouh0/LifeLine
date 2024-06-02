import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_cubit.dart';
import 'package:untitled/bloc/app_state.dart';
import 'package:untitled/screen/customer/customer_myorders.dart';
import 'package:untitled/screen/customer/customeraccount.dart';

import 'package:untitled/screen/auth/signin_page.dart';

class CustomerSettingsPage extends StatelessWidget {
  const CustomerSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff078EB2),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildSettingOption(context, 'Account', onTap: () {Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomerAccountPage()),
          );
            // Perform action when Account is tapped

          }),
          _buildSettingOption(context, 'History', onTap: () {
            // Show confirmation dialog before clearing history
            _showHistoryClearConfirmationDialog(context);
          }),
          _buildSettingOption(context, 'Language', onTap: () {
            // Open language selection dialog
            _showLanguageSelectionDialog(context);
          }),
          _buildSettingOption(context, 'Logout', onTap: () {
            // Show confirmation dialog before logging out
            _showLogoutConfirmationDialog(context);
          }),
        ],
      ),
    );
  }

  Widget _buildSettingOption(BuildContext context, String title,
      {VoidCallback? onTap}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: const Color(0xff078EB2), // Set the color of the card to blue
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18.0, color: Colors.white), // Set font color to white
        ),
        onTap: onTap,
      ),
    );
  }

  void _navigateToAccountPage(BuildContext context) {
    // Implement navigation to account page
    // For example:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => AccountPage()),
    // );
  }

  void _showHistoryClearConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text('Are you sure you want to clear your history?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: const Text('English'),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
         BlocListener<AppCubit,AppState>(
             listener: (context,state){
               if(state is LogoutState){
                 Navigator.pop(context);
                 _logout(context);
               }
             },
         child:  TextButton(
           onPressed: () {
             BlocProvider.of<AppCubit>(context).logout();

           },
           child: const Text('Yes'),
         ),),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false,
    );
  }
}
