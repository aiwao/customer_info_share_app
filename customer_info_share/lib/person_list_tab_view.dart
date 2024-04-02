import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:customer_info_share/person.dart';
import 'package:customer_info_share/person_detail_page.dart';

class PersonListTabView extends StatefulWidget {
  const PersonListTabView({super.key});

  @override
  PersonListTabViewState createState() => PersonListTabViewState();
}

class PersonListTabViewState extends State<PersonListTabView> {
  List<Map<dynamic, dynamic>> personsA = [];

  Future<void> getPersonsA() async {  
    final ref = FirebaseDatabase.instance.ref();
    debugPrint('getPersonsA');
    await ref.child('personinfoA').get().then((data) {
      setState(() {
        for (var c in data.children) {
          debugPrint('${c.value}');
          personsA.add(c.value as Map<dynamic, dynamic>);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getPersonsA();
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
              itemCount: personsA.length,
              itemBuilder: (context, index) {
                var pa = personsA[index];
                Person person = Person();
                person.no = pa['no'];
                person.name = pa['name'];
                person.id = 'person${person.no}';
                person.phonetic = pa['phonetic'];
                person.company = pa['company'];
                return ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(person.name),
                      Text(person.phonetic,
                        style: const TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(person.company),
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return PersonDetailPage(person);
                        }),
                      );
                  }
                );
              });
  }
}
