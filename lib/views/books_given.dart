import 'dart:convert';

import 'package:book__share/constants/constants.dart';
import 'package:book__share/controllers/controllers.dart';
import 'package:book__share/models/models.dart';
import 'package:book__share/views/add_books.dart';
import 'package:book__share/views/allbooks.dart';
import 'package:book__share/views/book_details.dart';
import 'package:book__share/views/given_book_details.dart';
import 'package:book__share/views/profilepage.dart';
import 'package:book__share/views/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BooksGivenPage extends StatefulWidget {
  const BooksGivenPage({super.key});

  @override
  State<BooksGivenPage> createState() => _BooksGivenPageState();
}

class _BooksGivenPageState extends State<BooksGivenPage> {
  final BooksGivenController _booksGivenController = BooksGivenController();

  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      await _booksGivenController.fetchDatabase();
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
  String? user_id;

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
                : _booksGivenController.booksgivenList.isEmpty
                    ? const Center(
                        child: Text(
                          "No RESOURCE available.",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : GridView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          crossAxisSpacing: 16, // Spacing between columns
                          mainAxisSpacing: 16, // Spacing between rows
                          childAspectRatio:
                              0.68, // Aspect ratio of each grid item
                        ),
                        itemCount: _booksGivenController.booksgivenList.length,
                        itemBuilder: (context, index) {
                          BooksGivenModel booksGivenModel =
                              _booksGivenController.booksgivenList[index];
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: themecolor.withOpacity(0.1),
                              border: Border.all(width: 2, color: themecolor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                        "http://$ip/bookshare/uploads/${booksGivenModel.image}",
                                      )
                                          // 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSFXmE6cRQjMvHbAHU2HALzpQR7wVo48gzyrG6OWY5Si2tM3Qc1')
                                          ),
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
                                  //  Spacer(),
                                  Center(
                                    child: Text(
                                      booksGivenModel.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),

                                  // Text(booksGivenModel.author),
                                  // Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Return Date ',
                                          textAlign: TextAlign.center,
                                          
                                          style: TextStyle(color: Colors.red,fontSize: 12),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          booksGivenModel.returnDate ??
                                              'After 20 days',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  ),

                                  SizedBox(
                                    height: 30,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: themecolor,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      GivenBookDetails(
                                                          bid: booksGivenModel.bid,
                                                          booking_id:
                                                              booksGivenModel.id,
                                                          title: booksGivenModel.title,
                                                          author: booksGivenModel.author,
                                                          genre: booksGivenModel.genre,
                                                          description:
                                                              booksGivenModel.description,
                                                          image:  booksGivenModel.image,
                                                          ownerId: booksGivenModel.ownerId,
                                                          status:   booksGivenModel.status,
                                                          contact: booksGivenModel.contact,
                                                          email: booksGivenModel.email,
                                                          name: booksGivenModel.name,
                                                          return_date:
                                                                booksGivenModel.returnDate,
                                                         
)));
                                        },
                                        child: Text(
                                          'RESOURCE returned',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
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
    );
  }
}
