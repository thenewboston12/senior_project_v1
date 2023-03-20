import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_japan_v3/app.dart';

import 'package:firebase_core/firebase_core.dart'; 
import 'package:flutter_japan_v3/utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform, 
  ); 

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
