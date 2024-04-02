import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:customer_info_share/user_auth_page.dart';

class TestPage extends StatefulWidget {
  final email = '';
  const TestPage({super.key});

  @override
  TestPageState createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String? txt = '';
  List<Map<dynamic, dynamic>>? personsA = [];
  DataSnapshot? s;

  @override
  void initState() {
    super.initState();
    getPersonsA();
  }

  Future<void> getPersonsA() async {
    personsA = [];
    final ref = FirebaseDatabase.instance.ref();
    debugPrint('getPersonsA');
    s = await ref.child('personinfoA').get();
  }

  @override
  Widget build(BuildContext context) {
    if (s != null) {
      debugPrint('$s');
      if (s != null) {
        debugPrint('${s?.children.length}');
        for (var c in s!.children) {
          personsA?.add(c.value as Map<dynamic, dynamic>);
        }
        debugPrint('length of personsA: ${personsA?.length}');
      }
    }
    if (personsA!.isNotEmpty) {
      debugPrint('build');
      return MaterialApp(
        title: 'もういやだ',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('ログアウト'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return UserAuthPage();
                    }),
                  );
                },
              ),
            ],
          ),
          body: ListView.builder(
              itemCount: personsA?.length,
              itemBuilder: (context, index) {
                debugPrint('name: ${personsA?[index]['name']}');
                return ListTile(
                  title: Text(personsA?[index]['name']),
                );
              }),
        ),
      );
    } else {
      return const Center(
        child: Text('error'),
      );
    }
  }
}
