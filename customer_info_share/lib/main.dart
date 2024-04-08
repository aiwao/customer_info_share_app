import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:customer_info_share/customer_info_share.dart';

import 'package:camera/camera.dart';
import 'register_textfield.dart';


Future<void> main() async {
  // https://zenn.dev/t_fukuyama/articles/2c61f68954d729
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//  runApp(const AuthPage());
  //runApp(const CustomerInfoShareApp());
  runApp(MaterialApp(
    home: PersonRegisterPage()));
}  

class PersonRegisterPage extends StatefulWidget {
  @override
  PersonRegisterPageState createState() => PersonRegisterPageState();
}

class PersonRegisterPageState extends State<PersonRegisterPage> {

  Image? imgFront;
  Image? imgBack;
  late CameraDescription firstCamera;
  Map<String, dynamic> textFields = {};

  @override
  void initState() {
    super.initState();
    imgFront = Image.asset('assets/image/placeholder.png');
    imgBack = Image.asset('assets/image/placeholder.png');
    prepareCamera();
    textFields['name'] = RegisterTextField('name', '名前を入力してください');
    textFields['phonetic'] = RegisterTextField('phonetic', 'ふりがなを入力してください');
    textFields['phone'] = RegisterTextField('phone', '電話番号を入力してください');
  }

  Future<void> prepareCamera() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return 
       Scaffold(
        appBar: AppBar(
          title: const Text('名刺登録'),
        ),
        body: SingleChildScrollView(
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('名前'),
              const Padding(padding: EdgeInsets.only(top: 10)),
              textFields['name'],
              const Padding(padding: EdgeInsets.only(top: 15)),
              const Text('ふりがな'),
              const Padding(padding: EdgeInsets.only(top: 10)),
              textFields['phonetic'],
              const Padding(padding: EdgeInsets.only(top: 15)),
              const Text('電話番号'),
              const Padding(padding: EdgeInsets.only(top: 10)),
              textFields['phone'],
              const Padding(padding: EdgeInsets.only(top: 15)),
              ElevatedButton(
                onPressed: () async {
                var image = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(camera: firstCamera),
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
                    builder: (context) => TakePictureScreen(camera: firstCamera),
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
      ),
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
*/

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
