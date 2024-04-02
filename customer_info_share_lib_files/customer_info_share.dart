import 'package:flutter/material.dart';
import 'package:customer_info_share/user_auth_page.dart';
import 'package:customer_info_share/customer_info_list_page.dart';

class CustomerInfoShareApp extends StatelessWidget {
  const CustomerInfoShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cusstomer Information Sharing Application',
      home: CustomerInfoListPage(),
      //UserAuthPage(),
    );
  }
}

