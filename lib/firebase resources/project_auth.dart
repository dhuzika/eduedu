import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto/firebase%20resources/storage_methods.dart';
import 'package:projeto/models/post.dart';
import 'package:projeto/models/comentario.dart';

class ProjectAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createProject(
      Uint8List imageFile,
      List<Comentario> comentarios,
      String projectTitle,
      String projectDescription,
      List<String> projectLanguage,
      String authorId,
      String autor) async {
    final _user = FirebaseAuth.instance.currentUser;
    String imageUrl = await StorageMethods()
        .uploadImageToStorage('ProjectLogo', imageFile, true);
    DateTime _now = DateTime.now();
    if (_user != null) {
      final authorId = _user.uid;

      // Referência para a coleção 'projects' no Firestore
      final projectsCollection =
          FirebaseFirestore.instance.collection('projects');

      // Dados do projeto, incluindo a URL da imagem e o authorId
      final projeto = Projeto(
          imageFileUrl: imageUrl,
          autorId: authorId,
          autor: autor,
          titulo: projectTitle,
          descricao: projectDescription,
          dataCriacao: _now,
          linguagens: projectLanguage,
          comentarios: comentarios);

      // Adicione o documento do projeto ao Firestore
      await projectsCollection.add(projeto.toJson());

      // Resto do código para criar o projeto...
    } else {
      print('Nenhum usuário autenticado.');
    }
  }
}
