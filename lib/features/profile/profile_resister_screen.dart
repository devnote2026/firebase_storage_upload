import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

class ProfileResisterScreen extends StatefulWidget {
  const ProfileResisterScreen({super.key});

  @override
  State<ProfileResisterScreen> createState() => _ProfileResisterScreenState();
}

class _ProfileResisterScreenState extends State<ProfileResisterScreen> {
  File? image;
  ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      image = File(pickedFile.path);
    });
  }

  void next(){
    context.go('/home');
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar : AppBar(
        title:  const Text('プロフィール登録'),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius : 60,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null ? const Icon(Icons.person, size: 60) : null,
            ),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: pickImage, child: Text("画像を選択する")),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: next, child: Text("次へ")),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: (){
              context.go('/home');
            }, child: Text('スキップ')
            )
          ]
        ),
      )
    );
  }
}