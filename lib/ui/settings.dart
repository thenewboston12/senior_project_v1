import 'package:flutter/material.dart';
import 'package:flutter_japan_v3/ui/main_page.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool cigarette = false;
  bool mask = false;
  bool phone = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[300],
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MainPage()));
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Column(children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Cigarette detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: cigarette,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      setState(() {
                        cigarette = value;
                      });
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Cell phone detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: phone,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      setState(() {
                        phone = value;
                      });
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: const Text("Mask detection",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1)),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Switch(
                    value: mask,
                    activeColor: Colors.black,
                    onChanged: (bool value) {
                      setState(() {
                        mask = value;
                      });
                    }),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.black,
                  shadowColor: Colors.black),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: const Text("Save changes",
                  style: TextStyle(color: Colors.white))),
        ]),
      ),
    );
  }
}
