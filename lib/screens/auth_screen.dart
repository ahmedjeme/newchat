import 'dart:io';
import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _fireAuth = FirebaseAuth.instance;
  var _isLoading = false;

  void _authFunction(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;
    try {
      // setState(() {
      //   _isLoading = true;
      // });
      if (isLogin) {
        authResult = await _fireAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print('login clicked ${authResult.user.email}');
      } else {
         authResult = await _fireAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();
       await Firestore.instance
            .collection('Users')
            .document(authResult.user.uid)
            .setData(
          {
            'email': email,
            'username': userName,
            'image_url': url,
          },
        );
      }
    } on PlatformException catch (err) {
      var message = 'An error occured, Please check your credentials';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      // setState(() {
      //   _isLoading = false;
      // });
    } catch (err) {
      print(err);
      // setState(() {
      //   _isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_authFunction),
    );
  }
}
