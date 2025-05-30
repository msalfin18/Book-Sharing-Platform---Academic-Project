import 'dart:convert';

import 'package:book__share/constants/constants.dart';
import 'package:book__share/controllers/controllers.dart';
import 'package:book__share/models/models.dart';
import 'package:book__share/views/add_books.dart';
import 'package:book__share/views/allbooks.dart';
import 'package:book__share/views/book_details.dart';
import 'package:book__share/views/profilepage.dart';
import 'package:book__share/views/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MybooksPage extends StatefulWidget {
  const MybooksPage({super.key});

  @override
  State<MybooksPage> createState() => _MybooksPageState();
}

class _MybooksPageState extends State<MybooksPage> {

  final MybooksController _mybooksController = MybooksController();

  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      await _mybooksController.fetchmybooks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch books data.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();
   fetchIp();
  }
  String? ip;
  String? user_id ;

Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    user_id = prefObj.getString('uid')?.trim();


    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      backgroundColor: themecolor,
      elevation: 0,


    ),
    body: Column(
      children: [
       
  
        // Main Content
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _mybooksController.mybookslist.isEmpty
                  ? const Center(
                      child: Text(
                        "No books available.",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of items per row
                        crossAxisSpacing: 16, // Spacing between columns
                        mainAxisSpacing: 16, // Spacing between rows
                        childAspectRatio: 0.68, // Aspect ratio of each grid item
                      ),
                      itemCount: _mybooksController.mybookslist.length,
                      itemBuilder: (context, index) {
                        MybooksModel mybooksModel =
                            _mybooksController.mybookslist[index];
                        return Container(
                          // height: 500,
                          decoration: BoxDecoration(
                            color: themecolor.withOpacity(0.1),
                            border: Border.all(width: 2, color: themecolor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0 ,left: 8,right: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                    Spacer(),
                         Container(
                          height: 150,
                          decoration: BoxDecoration(
                            image:  DecorationImage(image: NetworkImage( 
                              
                              "http://$ip/bookshare/uploads/${mybooksModel.image}",
                              // 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSFXmE6cRQjMvHbAHU2HALzpQR7wVo48gzyrG6OWY5Si2tM3Qc1'
                              
                              )), 
                          ),
                          // child: Padding(
                          //   padding: const EdgeInsets.all(0.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.end,
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       IconButton(
                          //         onPressed: (){
                          //                  add_to_fav(booksviewModel.bid, user_id! , booksviewModel.ownerId);
                          //         },
                          //         icon: Icon(Icons.favorite_outline , color: Colors.white,))
                          //     ],
                          //   ),
                          // ),
                         ),
                         Spacer(),
                                 Center(
                                   child: Text(
                                    mybooksModel.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                                                   ),
                                 ),
                                 
                        
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                Text(mybooksModel.genre ,),
                               
                                  ],
                                ),
                           Text(mybooksModel.author),
                                Spacer(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 55,
            width: 120,
            child: FloatingActionButton(
              isExtended: true,
              backgroundColor: themecolor,
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddBooksPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'ADD',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
        
  );
  }
}
