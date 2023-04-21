import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_japan_v3/ui/empty_profile_page.dart';
import 'package:flutter_japan_v3/ui/profile.dart';
import 'package:flutter_japan_v3/ui/profile_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static String routeName = "/signin";

  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
  void Function() signUserIn(context) {
    //show loading circle
    void signIn() async {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        if (context.mounted) Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ProfilePage1();
        }));
      } on FirebaseAuthException catch (e) {
        //Navigator.pop(context);

        if (e.code == 'user-not-found') {
          wrongEmailMessage(context);
        } else if (e.code == 'wrong-password') {
          wrongPasswordMessage(context);
        }
      }
    }

    //pop the loading circle
    //if (context.mounted) Navigator.pop(context);
    return signIn;
  }

  void wrongEmailMessage(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email'),
          );
        });
  }

  void wrongPasswordMessage(context) {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Password'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  TabBar(
                    tabs: [
                      Tab(child: Text('Sign In')),
                      Tab(child: Text('Sign Up')),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                  )
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Welcome back!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 36,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      //username textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey[400])!, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.yellow[600])!, width: 2.5)),
                            labelText: 'Email address',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //password textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey[400])!, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.yellow[600])!, width: 2.5)),
                            labelText: 'Password',
                            focusColor: Colors.yellow[600],
                            labelStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      //forgot password?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 290),
                      //sign in button

                      Expanded(
                        child: Stack(children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 25.0, bottom: 0),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EmptyProfilePage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Or continue offline",
                                        style: TextStyle(
                                          color: Color(0xFF757575),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                  )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: IntrinsicHeight(
                                    child: Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: signUserIn(context),
                                        child: Container(
                                          width: 80,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          decoration: BoxDecoration(
                                              color: Colors.yellow[600],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_right_alt,
                                              size: 36.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )))
                        ]),
                      )
                    ]),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: Column(children: [
                      const Padding(
                        padding:
                            EdgeInsets.only(top: 25.0, left: 50.0, right: 50.0),
                        child: Text(
                          'Start your journey with us!',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 36,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 25),

                      //username textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: emailController,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey[400])!, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.red[600])!, width: 2.5)),
                            labelText: 'Email address',
                            labelStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                      //password textfield
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey[400])!, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.pinkAccent[400])!,
                                    width: 2.5)),
                            labelText: 'Password',
                            focusColor: Colors.pinkAccent[400],
                            labelStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.grey[400])!, width: 1.5)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: (Colors.pinkAccent[400])!,
                                    width: 2.5)),
                            labelText: 'Repeat password',
                            focusColor: Colors.pinkAccent[400],
                            labelStyle: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ),

                      const SizedBox(height: 200),
                      //sign in button

                      Expanded(
                        child: Stack(children: [
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, bottom: 12.0),
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                      color: Color(0xFF757575),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.grey[200],
                                ),
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: IntrinsicHeight(
                                    child: Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: signUserIn(context),
                                        child: Container(
                                          width: 80,
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          decoration: BoxDecoration(
                                              color: Colors.pinkAccent[400],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: const Center(
                                            child: Icon(
                                              Icons.arrow_right_alt,
                                              size: 36.0,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  )))
                        ]),
                      )
                    ]),
                  ),
                ),
              )
            ])));
  }
}
