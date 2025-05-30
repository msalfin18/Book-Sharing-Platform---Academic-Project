import 'dart:convert';

import 'package:book__share/constants/constants.dart';
import 'package:book__share/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class FeedbackPage extends StatefulWidget {
  final String bood_id;
  final String title;
  final String author;
  final String owner_id;

  FeedbackPage({
    Key? key,
    required this.bood_id,
    required this.title,
    required this.author,
    required this.owner_id
  }) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
   fetchIp();
  }

  String? ip;

  String? uid ;

Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    uid = prefObj.getString('uid')?.trim();


    // await fetchData();
  }

   late String url = "http://$ip/bookshare/feedback.php";

  void _feedbackupload() async{
    var response = await http.post(Uri.parse(url),
    body: {
          "feedback":_feedbackController.text.trim(),
          "book_id":widget.bood_id,
          "user_id":uid,
          "owner_id":widget.owner_id,
   
    }
    
    );
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success'){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succesfully registed")));
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registartion Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        title: const Text('Feedback'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: themecolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Author: ${widget.author}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _feedbackController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your feedback...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          width: 2,
                          color: themecolor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Feedback cannot be empty.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themecolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          _feedbackupload();
                        
                        }
                      },
                      child: const Text(
                        'Upload',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
