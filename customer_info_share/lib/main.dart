import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:customer_info_share/customer_info_share.dart';



void main() async {
  // https://zenn.dev/t_fukuyama/articles/2c61f68954d729
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//  runApp(const AuthPage());
  runApp(const CustomerInfoShareApp());
}
