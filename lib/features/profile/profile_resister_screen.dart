import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

import 'profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileResisterScreen extends StatefulWidget {
  const ProfileResisterScreen({super.key});

  @override
  State<ProfileResisterScreen> createState() => _ProfileResisterScreenState();
}

class _ProfileResisterScreenState extends State<ProfileResisterScreen> {
  File? image;
  ImagePicker picker = ImagePicker();
  final profileService = ProfileService(); 

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    setState(() {
      image = File(pickedFile.path);
    });
  }

  Future<void> savePhoto() async {
    if(image == null) return;

    final uid = FirebaseAuth.instance.currentUser!.uid; 
    final url = await profileService.uploadProfileImage(uid,image!);

    //Cloud Firestore を更新
    await FirebaseFirestore.instance
                           .collection("users")
                           .doc(uid)
                           .update({
                            "profileImageUrl": url,
                            "needsProfilePhotoSetup": false
                           });             
    context.go('/home');
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

            ElevatedButton(onPressed: savePhoto, child: Text("次へ")),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: next,
                           child: Text('スキップ')
            )
          ]
        ),
      )
    );
  }
}