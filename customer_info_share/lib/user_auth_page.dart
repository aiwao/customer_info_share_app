import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_info_share/customer_info_list_page.dart';

class UserAuthPage extends StatelessWidget {
  const UserAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('認証ページ'),
        centerTitle: true,
      ),
      body: const Center(
        child: UserAuthBox(),
      ),
    );
  }
}

class UserAuthBox extends StatefulWidget {
  const UserAuthBox({super.key});

  @override
  UserAuthBoxState createState() => UserAuthBoxState();
}

class UserAuthBoxState extends State<UserAuthBox> {
  String infoText = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
              ),
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'パスワード（6文字以上）',
              ),
              obscureText: true,
              onChanged: (String value) {
                setState(() {
                  password = value;
                });
              },
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(infoText),
            ),
            /*SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ユーザー登録'),
                  onPressed: () async {
                    try {
                      // メールパスワードでユーザー登録
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      // ユーザ登録に成功した場合、画面遷移
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return TestPage();
                        }),
                      );
                    }
                    catch (e) {
                        // ユーザー登録に失敗した場合
                      setState(() {
                        infoText = '登録に失敗しました：${e.toString()}';
                      });
                    }
                  },
                ),
              ),*/
            const SizedBox(
              height: 8,
            ),
            Container(
              child: OutlinedButton(
                  child: const Text('ログイン'),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final FirebaseAuth auth = FirebaseAuth.instance;
                      final result = await auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CustomerInfoListPage();
                        }),
                      );
                    } catch (e) {
                      setState(() {
                        infoText = 'ログインに失敗しました：${e.toString()}';
                      });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
