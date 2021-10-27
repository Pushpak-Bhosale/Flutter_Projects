import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/widgets/auth/auth_form.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    File? image,
    bool isLogin,
    BuildContext ctx,
  ) async {
    // ignore: unused_local_variable
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(image!).whenComplete(() => null);

        String url = await ref.getDownloadURL();
        print(url);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set(
          {
            'username': username,
            'email': email,
            'image_url': url,
          },
        );
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials!';
      if (err.message != null) {
        message = err.message!;
      }

      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
      // ignore: deprecated_member_use
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.toString()),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Theme.of(ctx).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
