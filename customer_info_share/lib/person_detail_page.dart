import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:customer_info_share/person.dart';


class PersonDetailPage extends StatefulWidget {
  final Person person;
  const PersonDetailPage(this.person, {super.key});

  @override
  PersonDetailPageState createState() => PersonDetailPageState();
}
class PersonDetailPageState extends State<PersonDetailPage> {
  Person? person;
  String cardFrontImgUrl = '';
  String cardBackImgUrl = '';

  @override
  void initState() {
    super.initState();
    person = widget.person;
    getPersoninfoB();
    getPersonCardImgUrls(); 
  }

  Future<void> getPersoninfoB() async {
    debugPrint('getPersonInfoB');
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('personinfoB/${widget.person.id}').get();
    Map<dynamic, dynamic> m = snapshot.value as Map<dynamic, dynamic>;
    debugPrint('person.id: ${widget.person.id}');
    if (m['phone'] != null) {
      debugPrint('phone: ${m['phone']}');
      widget.person.phone = m['phone'];
    }
    else {
      debugPrint('phone is null');
    }
  }

  Future<void> getPersonCardImgUrls() async {
    final ref = FirebaseStorage.instance.ref();
    await ref.child('cards/sample/sample_card.jpg').getDownloadURL().then((value) {
      setState(() {
        cardFrontImgUrl = value;

      });
    });
    await ref.child('cards/sample/sample_card.jpg').getDownloadURL().then((value) {
      setState(() {
        cardBackImgUrl = value;
      });
    });
    debugPrint('cardFrontImgUrl: $cardFrontImgUrl');
    debugPrint('cardBackImgUrl: $cardBackImgUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${person?.name}さんの詳細'),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            GestureDetector(
              child: Text('☎ ${person?.phone != '' ? person?.phone : 'なし'}'),
              onTap: () {
                launchUrl(Uri.parse('tel:${person?.phone != '' ? person?.phone : ''}'));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            /*Image.network(
              cardFrontImgUrl,
            ),
            */
            InteractiveViewer(
              minScale: 1,
              maxScale: 7,
              child: Image.network(
                cardFrontImgUrl,
                errorBuilder: (context, error, stacktrace) {
                  debugPrint('cardFrontImgUrl: $cardFrontImgUrl');
                  debugPrint('XXXXError: $error');
                  return const Text('読込中。。。');
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Image.network(
              cardBackImgUrl,
              errorBuilder: (context, error, stacktrace) {
                /*debugPrint('cardFrontImgUrl: $cardFrontImgUrl');*/
                debugPrint('XXXXError: $error');
                return const Text('読み込み中。。。');
              },
            ),
          ],
        ),
      ),
    );
  }
}
