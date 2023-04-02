import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_japan_v3/ui/main_page.dart';
import 'package:flutter_japan_v3/ui/settings.dart';
import 'package:flutter_japan_v3/ui/loginpage.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOut() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[300],
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginPage();
                    }));
                  },
                  icon: const Icon(Icons.logout, color: Colors.black))
            ]),
        body: Stack(children: <Widget>[
          Container(
            color: Colors.grey[300],
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * 0.3) / 2),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/1490711.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
                bottom: (MediaQuery.of(context).size.height * 0.3) / 2),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.black,
                    shadowColor: Colors.black),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const MainPage();
                    })
                  );
                },
                child: const Text(
                  "Start detecting",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }
}
