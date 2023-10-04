import 'package:flutter/material.dart';
import 'dart:io';
// import 'add_image.dart';
import 'criar_projeto_screen.dart';
import 'package:projeto/header.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto/firebase%20resources/project_auth.dart';
import 'package:projeto/firebase%20resources/user_auth.dart';
import 'package:projeto/utils/constants.dart';
import 'package:projeto/views/screens/criar_projeto_screen.dart';
import 'package:projeto/views/screens/recuperar_senha_screen.dart';
import 'package:projeto/views/widgets/button.dart';
import 'package:projeto/views/widgets/text_input_field.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppState(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}

class AppState extends StatefulWidget {
  late final ProjectAuth projAuth;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<AppState> {
  List<ImageData> _imageDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      body: ListView.builder(
        itemCount: _imageDataList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Stack(
              children: [
                Image.file(_imageDataList[index].imageFile),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    _imageDataList[index].title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Text(
                    _imageDataList[index].description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 270,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 40,
                        icon: Icon(Icons.message_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        color: Colors.white,
                        iconSize: 40,
                        icon: Icon(Icons.content_paste_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (context) => CriarProjetoPage(),
            ),
          )
              .then((newImageData) {
            if (newImageData != null) {
              setState(() {
                _imageDataList.add(newImageData);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ImageData {
  final File imageFile;
  final String title;
  final String description;

  ImageData(this.imageFile, this.title, this.description);
}
