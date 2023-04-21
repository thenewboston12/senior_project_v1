import 'package:flutter/material.dart';
import 'package:flutter_japan_v3/ui/navbar.dart';

import 'loginpage.dart';

class EmptyProfilePage extends StatelessWidget {
  const EmptyProfilePage({Key? key}) : super(key: key);
  static String routeName = '/profile-empty';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.black),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return LoginPage();
                      }));
                },
                icon: const Icon(Icons.logout, color: Colors.black))
          ]),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  children: const [
                    SizedBox(height: 200),
                    Center(
                      child: Text(
                        "There is no data on your past rides.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: Text(
                          "Please Sign In to see information about your past detections.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                    SizedBox(height: 50),
                    Center(
                      child: Text(
                          "Please Sign Up to start data tracking.",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center
                      ),
                    ),
                  ],
                )
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBarFb1(),
    );
  }
}
