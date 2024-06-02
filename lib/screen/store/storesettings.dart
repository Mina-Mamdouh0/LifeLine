import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/screen/auth/signin_page.dart';
import 'package:untitled/screen/store/storeeditpage.dart';
import '../../bloc/app_cubit.dart';
import '../../bloc/app_state.dart';

class StoreSettings extends StatelessWidget {
  const StoreSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xff078EB2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Center(
            child: Icon(
              Icons.settings,
              size: 100.0,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 30.0),
          _buildSettingOption(
              Icons.account_circle, 'My Account', () =>
              _navigateToMyAccount(context)),
          _buildSettingOption(Icons.location_on, 'Location Update',
                  () => _handleLocationUpdate(context)),
          _buildSettingOption(
              Icons.history, 'Clear History', () =>
              _confirmClearHistory(context)),
          _buildSettingOption(
              Icons.logout, 'Log Out', () => _confirmLogout(context)),
        ],
      ),
    );
  }

  Widget _buildSettingOption(IconData icon, String title,
      VoidCallback onTapCallback) {
    return GestureDetector(
      onTap: onTapCallback,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40.0, color: Colors.black),
            const SizedBox(width: 20.0),
            Text(
              title,
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMyAccount(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StoreEditPage()),
    );
  }

  void _handleLocationUpdate(BuildContext context) {
    // Navigate to the screen where the location can be updated using Google Maps
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StoreEditPage()),
    );
  }

  void _confirmClearHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Clear History"),
          content: const Text("Are you sure you want to clear your history?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                _clearHistory(context);
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
            BlocListener<AppCubit,AppState>(
              listener: (context,state){
                if(state is LogoutState){
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPage()),(route) => false,
                  );
                }
              },
              child:  TextButton(
                onPressed: () {
                  BlocProvider.of<AppCubit>(context).logout();

                },
                child: const Text('Yes'),
              ),),
          ],
        );
      },
    );
  }


  void _clearHistory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("History cleared."),
      ),
    );
  }
}


