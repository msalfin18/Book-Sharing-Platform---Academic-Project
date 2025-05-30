import 'dart:convert';

import 'package:book__share/views/homepage.dart';
import 'package:book__share/views/registration.dart';
import 'package:flutter/material.dart';
import 'package:book__share/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for the username and password fields
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  // Define a form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

   late String url = "http://$_ip/bookshare/login.php";

void  loginnew(ctx)async{
         var data = {
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim()
         };

         var response = await http.post(Uri.parse(url),
         body: data 
         );
         if (response.statusCode == 200){   
          print(response.body);
         

    var jsonData = jsonDecode(response.body);   
    var jsonString = jsonData['message'];
    print(jsonString);


    if(jsonString == 'success'){

        var jsonUserData = jsonData['userinfo'];
        print(jsonUserData);

        String uid = jsonData['userinfo']['id'];
       
        saveUserData(uid);

      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text("success")));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage(name: jsonData['userinfo']['name'],)));
   

    }else{

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect Email or Password')));
    }


         }
         else {
     ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('Login Failed')));
    }
}

  void saveUserData(String uid) async{

        SharedPreferences prefobj = await SharedPreferences.getInstance();
               await prefobj.setString('uid', uid );
               print(prefobj);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16.0), // Add padding for better spacing
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
                    'Book Share',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: themecolor,
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        hintText: 'username',
                        prefixIcon: Icon(
                          Icons.person,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      obscureText: true, // Hides the password input
                      decoration: InputDecoration(
                        hintText: 'password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                          // Perform login logic here
                         loginnew(context);
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
        
                  TextButton(
                    onPressed: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: 
                  (context)=> RegistrationPage()));
                    },
                    child: Text(
                      'Sign up',
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
