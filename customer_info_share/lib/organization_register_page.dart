import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'register_textfield.dart';

class OrganizationRegisterPage extends StatefulWidget {
  const OrganizationRegisterPage({super.key});

  @override
  OrganizationRegisterPageState createState() => OrganizationRegisterPageState();
}

class OrganizationRegisterPageState extends State<OrganizationRegisterPage> {
  Map<String, dynamic> textFields = {};
  String? orgType = '株式会社';

  @override
  void initState() {
    super.initState();
    textFields['name'] = RegisterTextField('name', '名前を入力してください');
    textFields['phonetic'] = RegisterTextField('phonetic', 'ふりがなを入力してください');
    textFields['phone'] = RegisterTextField('phone', '電話番号を入力してください');
    textFields['address'] = RegisterTextField('address', '住所を入力してください');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('in build');
    return MaterialApp(
      title: 'register test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('企業登録'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('名前'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    textFields['name'],
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text('ふりがな'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    textFields['phonetic'] as Widget,
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text('種別'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: '株式会社',
                          child: Text('株式会社'),
                        ),
                        DropdownMenuItem(
                          value: '有限会社',
                          child: Text('有限会社'),
                        ),
                        DropdownMenuItem(
                          value: '合同会社',
                          child: Text('合同会社'),
                        ),
                        DropdownMenuItem(
                          value: '＜なし＞',
                          child: Text('＜なし＞'),
                        ),
                      ],
                      value: orgType,
                      onChanged: (String? value) {
                        setState(() {
                          orgType = value;
                        });
                      }
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text('電話番号'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    textFields['phone'],
                    const Text('住所'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    textFields['address'],
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final name = textFields['name']?.strVal;
                            final phonetic = textFields['phonetic']?.strVal;
                            final phone = textFields['phone']?.strVal;
                            final address = textFields['address']?.strVal;
                            debugPrint('登録：$name');
                            debugPrint('登録：$phonetic');
                            debugPrint('登録：$phone');
                            debugPrint('登録：$address');
                            final t = DateTime.now().millisecondsSinceEpoch;
                            final orgid = 'organization$t';
                            DatabaseReference ref = FirebaseDatabase.instance.ref("organizations/$orgid");
                            await ref.set({
                                "name" : name,
                                "phonetic" : phonetic,
                                "phone" : phone,
                                "address" : address,
                                "type" : orgType,
                            }).then((_) {
                              debugPrint('登録成功');
                              }
                            ).catchError((e) {
                              debugPrint('登録失敗 : $e');
                              }
                            );
                          },
                          child: const Text('登録'),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        ElevatedButton(
                          child: const Text('クリア'),
                          onPressed: () {
                            setState(() {
                              orgType = '株式会社';
                            });
                            textFields.forEach((key, tf) => tf.clear());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

