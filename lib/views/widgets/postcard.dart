import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      print('b');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return ClipRRect(
              // Define o raio do arredondamento
          child: Container(
            width: 600,
            height: 700,
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 1,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ).copyWith(right: 0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/250?image=9',
                          //widget.snap['profImage'].toString(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'edu',
                                //widget.snap['username'].toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => {},
                        icon: Icon(Icons.more_vert_outlined),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                // STACK PARA SOBREPOR TEXTO NA IMAGEM
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      child: Image.network(
                        widget.snap['imageFileUrl'].toString(),
                        fit: BoxFit.contain,
                        height: 600,
                        width: width,
                      ),
                      
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: width,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.snap['titulo'].toString().toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                                
                              ),
                            ),
                          ]),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height*0.35,
                      left: 50,
                      right: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width*0.4,
                            padding: const EdgeInsets.all(
                                8), 
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(
                                  0.4),
                              borderRadius: BorderRadius.circular(
                                  8),
                            ),
                            child: Text(
                              widget.snap['descricao'],
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: width * 0.45,
                      right: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {print('$width e $height');},
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
              ],
            ),
          ),
        );
      },
    );
  }
}