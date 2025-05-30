
import 'package:book__share/constants/constants.dart';
import 'package:book__share/views/homepage.dart';
import 'package:book__share/views/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferanceHomePage extends StatefulWidget {
  PreferanceHomePage({super.key});

  @override
  State<PreferanceHomePage> createState() => _PreferanceHomePageState();
}

class _PreferanceHomePageState extends State<PreferanceHomePage> {
  

  late String ipv = "Fetching..."; // Holds the IPv4 address
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ipController = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ipController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter IP address";
                    }
                    return null;
                  },
                
                ),
              
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themecolor,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        SharedPreferences prefObj =
                            await SharedPreferences.getInstance();
                        await prefObj.setString('ip', _ipController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("IP address saved!")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      }
                    },
               
                    child:  Text(
                      "Go",
                      style: TextStyle(color: Colors.white),
                     
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
