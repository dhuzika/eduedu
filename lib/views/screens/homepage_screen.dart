import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/responsve/responsive_layout.dart';
// import 'package:projeto/views/screens/criar_projeto_screen.dart';
import 'package:projeto/views/widgets/postcard.dart';
import 'package:projeto/header.dart';

class HomePage extends StatefulWidget {
  // const HomePage({Key? key}) : super(key: key)

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<ImageData> _imageDataList = [];

  @override
  void initState() {
    super.initState();
    // _fetchImageDataFromFirebase();
  }

  // Future<void> _fetchImageDataFromFirebase() async {
  //   try {
  //     final QuerySnapshot snapshot =
  //         await FirebaseFirestore.instance.collection('projects').get();

  //     final List<ImageData> imageDataList = snapshot.docs.map((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       return ImageData(
  //         data['imageFileUrl'] ?? '',
  //         data['titulo'] ?? '',
  //         data['descricao'] ?? '',
  //       );
  //     }).toList();

  //     setState(() {
  //       _imageDataList = imageDataList;
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return ResponsiveLayout(child:Scaffold(
      backgroundColor: Colors.black,
      appBar: AppHeader(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Container(
              
              child: PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     for (int i = 0; i < _imageDataList.length; i++) {
      //       print(_imageDataList[i].imageUrl);
      //       print(_imageDataList[i].title);
      //       print(_imageDataList[i].description);
      //     }
      //     Navigator.of(context).push(
      //       MaterialPageRoute(
      //         builder: (context) => CriarProjetoPage(),
      //       ),
      //     );
      //   },
      //   child: Icon(Icons.add),
      // ),
    ));
  }
}

// class ImageData {
//   final String imageUrl; // URL of the image
//   final String title;
//   final String description;

//   ImageData(this.imageUrl, this.title, this.description);
// }