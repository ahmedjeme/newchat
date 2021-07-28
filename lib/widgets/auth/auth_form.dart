import 'dart:io';
import 'package:flutter/material.dart';

import '../image_picker.dart';

class AuthForm extends StatefulWidget {
  // final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) _authFn;

  AuthForm(this._authFn);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = '';
  var _userName = '';
  var _password = '';
  bool _isLogin = true;
  File _image;

  void _addImage(File userImage) {
    _image = userImage;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_image == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget._authFn(
        _email.trim(),
        _password.trim(),
        _userName.trim(),
        _image,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 300,
          color: Colors.redAccent,
          transform: Matrix4.rotationZ(25 / 1),
          child: Center(
            child: Text(
              'Chat App',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black87),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_addImage),
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          _email = newValue;
                        });
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Username should have at least 4 characters';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'User Name'),
                        onSaved: (newValue) {
                          setState(() {
                            _userName = newValue;
                          });
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password should have at least 7 numbers';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (newValue) {
                        setState(() {
                          _password = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // if(widget.isLoading)
                    //   CircularProgressIndicator(),
                    // if(!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: () {
                        if (_isLogin) {
                          _trySubmit();
                        }
                      },
                    ),
                    // if(!widget.isLoading)
                    FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create a new account'
                            : 'I have already an account'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
