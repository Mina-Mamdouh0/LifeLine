import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/screen/auth/newpass_page.dart';
import 'package:untitled/screen/auth/signin_page.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            stops: [0.4, 0.6],
            colors: [Color(0xff078EB2), Color(0xff0E4161)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back when the back button is pressed
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/image/my_logo.png',
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'Verification',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Enter the 4-digit code that you\nreceived on your email',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(style: BorderStyle.solid, color: Colors.white),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '-  -  -  -  ',
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 40),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Reset code logic here
                },
                child: Text('Reset Code'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewPasswordPage()));

                  // Reset code logic here
                },
                child: Text('Next'),
              ),
              SizedBox(height: 20),
              Image.asset('assets/image/icon7.png'),
            ],
          ),
        ),
      ),
    );
  }
}
