import 'dart:convert';

import 'package:book__share/views/login.dart';
import 'package:flutter/material.dart';
import 'package:book__share/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // Define a form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Define controllers for all fields
  final TextEditingController nameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController classController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController contactController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  SharedPreferences ? _readobj ;

late String _ip ;

@override
  void initState() {
  
    super.initState();
    _loadpref();

  }

  Future<void>_loadpref()async{
             _readobj = await SharedPreferences.getInstance();
             setState(() {
               _ip = _readobj ?.getString('ip') ?? "NO IP AVALABLE";
               print("current ip is ${_ip}");
             });
  }

   late String url = "http://$_ip/bookshare/registration.php";

  void _userreg(cntx) async{
    var response = await http.post(Uri.parse(url),
    body: {
          "name":nameController.text.trim(),
          "username":usernameController.text.trim(),
          "class":classController.text.trim(),
          "email":emailController.text..trim(),
           "contact":contactController.text.trim(),
          "password":passwordController.text.trim(),

    }
    
    );
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success'){
         ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(content: Text("Succesfully registed")));
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
    }else {
      ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(content: Text("Registartion Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: secondarycolor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themecolor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Username field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(
                          Icons.person,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Class field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: classController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your class';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Class',
                        prefixIcon: Icon(
                          Icons.school,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Email field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Contact field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: contactController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Contact No.',
                        prefixIcon: Icon(
                          Icons.phone,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Password field
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Register button
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                  
                           _userreg(context);

                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Sign in link
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: themecolor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
