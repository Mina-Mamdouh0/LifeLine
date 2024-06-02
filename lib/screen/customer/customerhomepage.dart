
import 'package:flutter/material.dart';
import 'package:untitled/screen/customer/customer_myorders.dart';
import 'package:untitled/screen/customer/customercartpage.dart';
import 'package:untitled/screen/customer/customersettingspage.dart';
import 'package:untitled/screen/customer/mostsalesproductpage.dart';
import 'package:untitled/screen/customer/nearest%20pharmacies%20page.dart';
import 'package:untitled/screen/customer/offerspage.dart';
import 'package:untitled/screen/customer/search.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff078EB2),
        title: const Text(
          'Customer Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return SearchPage();
              }));
            },
              child: Icon(Icons.search)),
          SizedBox(width: 20,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,width: double.infinity),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => const NearestPharmaciesPage()));
              },
              child: const Column(
                children: [
                  Icon(Icons.location_on, color: Colors.blueAccent, size: 50),
                  Text('Nearest Pharmacies', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            const SizedBox(height: 60),
            // Most Sales Products
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:
                    (context) => MostSalesProductsPage()));
                // Navigate to most sales products page or perform related action
                print('Most Sales Products pressed');
              },
              child: Column(
                children: [
                  Icon(Icons.shopping_bag, color: Colors.blueAccent, size: 50),
                  Text('Most Sales Products', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 60),
            // Offers
            GestureDetector(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder:
                  (context) => OffersPage()));
                // Navigate to offers page or perform related action
                print('Offers pressed');
              },
              child: Column(
                children: [
                  Icon(Icons.local_offer, color: Colors.blueAccent, size: 50),
                  Text('Offers', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: const ProfileDrawer(), // Adding the ProfileDrawer to the drawer property of Scaffold
    );
  }

  void _showProfilePanel(BuildContext context) {
    Scaffold.of(context).openEndDrawer(); // Open the right-side drawer
  }
}

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff078EB2),
            ),
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('My Orders'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyOrdersPage()),
              );
            },
          ),
         /* ListTile(
            title: const Text('My Wishlist'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWishlistPage()),
              );
            },
          ),*/
          ListTile(
            title: const Text('My Cart'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCartPage()),
              );
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CustomerSettingsPage()),
            );
              // Navigate to Settings page
            },
          ),
        ],
      ),
    );
  }
}
