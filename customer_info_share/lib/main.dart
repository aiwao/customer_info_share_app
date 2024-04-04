import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:customer_info_share/customer_info_share.dart';

import 'package:camera/camera.dart';


Future<void> main() async {
  // https://zenn.dev/t_fukuyama/articles/2c61f68954d729
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//  runApp(const AuthPage());
  //runApp(const CustomerInfoShareApp());
  runApp(RegisterTest());
}  

class RegisterTest extends StatefulWidget {
  const RegisterTest({super.key});

  @override
  RegisterTestState createState() => RegisterTestState();
}

class RegisterTestState extends State<RegisterTest> {
  Map<String, dynamic> fieldInfo = {};
  Map<String, MyTextField> textFields = {};

  @override
  void initState() {
    super.initState();
    textFields['name'] = MyTextField('name', '名前を入力してください');
    textFields['phonetic'] = MyTextField('phonetic', 'ふりがなを入力してください');
    textFields['address'] = MyTextField('address', '住所を入力してください');

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
                    MyTextField('name', '名前を入力してください'),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text('ふりがな'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    MyTextField('phonetic', 'ふりがなを入力してください'),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    const Text('住所'),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    MyTextField('address', '住所を入力してください'),
                    const Padding(padding: EdgeInsets.only(top: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final name = textFields['name']?.strVal;
                            final phonetic = textFields['phonetic']?.strVal;
                            final address = textFields['address']?.strVal;
                            debugPrint('登録：$name');
                            debugPrint('登録：$phonetic');
                            debugPrint('登録：$address');
                            final t = DateTime.now().millisecondsSinceEpoch;
                            final orgid = 'organization$t';
                            DatabaseReference ref = FirebaseDatabase.instance.ref("organizations");
                            ref.push();
                            await ref.set({
                              "organization$orgid" : {
                                "name" : name,
                                "phonetic" : phonetic,
                                "address" : address,
                              }
                            });
                          },
                          child: const Text('登録'),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 20)),
                        ElevatedButton(
                          child: const Text('クリア'),
                          onPressed: () {
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

class MyTextField extends StatefulWidget {
  final String fieldName;
  final String labelText;
  String strVal = '';
  int intVal = 0;

  final TextEditingController _controller = TextEditingController();

  MyTextField(this.fieldName, this.labelText, {Key? key}) : super(key: key);

  void clear() {
    debugPrint('MyTextField.clear');
    _controller.clear();
    strVal = '';
    intVal = 0;
  }

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {

  @override
  void dispose() {
    widget._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
      onChanged: (text) {
        widget.strVal = text;
        try {
          widget.intVal = int.parse(text);
        }
        catch(e) {
          widget.intVal = 0;
        }
      },
    );
  }
}
  

  /*
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  debugPrint('firstCamera：$firstCamera');
  runApp(MyApp(camera: firstCamera));
}
class MyApp extends StatelessWidget {
  final CameraDescription camera;
  
  const MyApp({
    Key? key,
    required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Example',
      theme: ThemeData(),
      home: RegPage(camera: camera),
    );
  }
}

class RegPage extends StatefulWidget {
  final CameraDescription camera;
  RegPage({Key? key, required this.camera}) : super(key: key);
  
  @override
  RegPageState createState() => RegPageState();
}

class RegPageState extends State<RegPage> {
  Image? imgFront;
  Image? imgBack;
  
  void initState() {
    super.initState();
    imgFront = Image.asset('assets/image/placeholder.png');
    imgBack = Image.asset('assets/image/placeholder.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('個人登録'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
               var image = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(camera: widget.camera),
                  fullscreenDialog: true,
                ));
                setState(() {
                  imgFront = image;
                });
              },
              child: Text('表'),
            ),
            SizedBox(
              height: 200,
              child: imgFront,
            ),
            ElevatedButton(
              onPressed: () async {
               var image = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(camera: widget.camera),
                  fullscreenDialog: true,
                ));
                setState(() {
                  imgBack = image;
                });
              },
              child: Text('裏'),
            ),
            SizedBox(
              height: 200,
              child: imgBack,
            ),
            
          ],

        ),
      ),
    );
  }
}

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  
  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool shutterEnabled = true;
    return Scaffold(
      body: Center(
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (shutterEnabled) {
            shutterEnabled = false;
            final image = await _controller.takePicture();
            Navigator.pop(context, Image.file(File(image.path)));

          }
          else {
            shutterEnabled = true;           
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.imagePath})
    : super(key: key);
  
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('撮れた写真')),
        body: Center(child: Image.file(File(imagePath))),
      );
  }
}

*/
