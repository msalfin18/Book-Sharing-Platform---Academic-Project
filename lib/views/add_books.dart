import 'dart:convert';
import 'dart:io';

import 'package:book__share/views/homepage.dart';
import 'package:book__share/views/login.dart';
import 'package:flutter/material.dart';
import 'package:book__share/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddBooksPage extends StatefulWidget {
  AddBooksPage({super.key});

  @override
  State<AddBooksPage> createState() => _AddBooksPageState();
}

class _AddBooksPageState extends State<AddBooksPage> {
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  SharedPreferences? _readobj;
  late String _ip;
  late String _uid;

  @override
  void initState() {
    super.initState();
    _loadpref();
  }

  Future<void> _loadpref() async {
    _readobj = await SharedPreferences.getInstance();
    setState(() {
      _ip = _readobj?.getString('ip') ?? "NO IP AVAILABLE";
      _uid = _readobj?.getString('uid') ?? "NO IP AVAILABLE";
      print("Current IP is $_ip");
    });
  }

  late String url = "http://$_ip/bookshare/add_books.php";

  String encodeImageToBase64() {
    if (_image != null) {
      List<int> imageBytes = _image!.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    }
    return '';
  }

  Future<void> _userreg(BuildContext cntx) async {

    String encodedImage = encodeImageToBase64();

    var response = await http.post(Uri.parse(url), body: {
      
      "title": _titlecontroller.text.trim(),
      "author": _authorController.text.trim(),
      "genre": _genreController.text.trim(),
      "description": _descriptioncontroller.text.trim(),
      'image': encodedImage,
      "owner_id": _uid,

    }
    );

    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {
      ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(content: Text("Successfully Added")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      ScaffoldMessenger.of(cntx).showSnackBar(SnackBar(content: Text(" Failed")));
    }
  }

  Future<void> requestCamera() async {
    var cameraStatus = await Permission.camera.status;

    if (cameraStatus.isGranted) {
      _openCamera();
    } else if (cameraStatus.isDenied) {
      if (await Permission.camera.request().isGranted) {
        _openCamera();
      } else {
        print("Camera permission denied");
      }
    } else if (cameraStatus.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  
  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Update _image with the selected camera image
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Update _image with the selected gallery image
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                    'Add your RESOURCE',
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
                      controller: _titlecontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Title',
                        prefixIcon: Icon(
                          Icons.book,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _authorController,
                      decoration: InputDecoration(
                        hintText: 'Author',
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
                      controller: _genreController,
                      decoration: InputDecoration(
                        hintText: 'Genre',
                        prefixIcon: Icon(
                          Icons.category,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _descriptioncontroller,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        prefixIcon: Icon(
                          Icons.description,
                          color: themecolor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_image == null) // Only show buttons if no image is selected
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            maximumSize: Size(double.infinity, 120),
                            elevation: 4,
                            backgroundColor: themecolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: requestCamera,
                          child: Text('Upload Image', style: TextStyle(color: Colors.white)),
                        ),
                    //   if (_image == null) // Only show buttons if no image is selected
                    //     ElevatedButton(
                    //       style: ElevatedButton.styleFrom(
                    //         maximumSize: Size(double.infinity, 120),
                    //         elevation: 4,
                    //         backgroundColor: themecolor,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //       onPressed: requestGallery,
                    //       child: Text('Upload From Gallery', style: TextStyle(color: Colors.white)),
                    //     ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _image == null
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: themecolor, width: 3),
                            color: Colors.grey[300],
                          ),
                          height: 200,
                          child: Center(child: Text('No image selected')),
                        )
                      : Image.file(_image!, height: 200),
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
                          _userreg(context);
                        }
                      },
                      child: Text(
                        'Add RESOURCE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                    child: Text(
                      'Home',
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
