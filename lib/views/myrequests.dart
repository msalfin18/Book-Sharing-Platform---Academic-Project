import 'dart:convert';
import 'package:book__share/constants/constants.dart';
import 'package:book__share/controllers/controllers.dart';
import 'package:book__share/models/models.dart';
import 'package:book__share/views/add_books.dart';
import 'package:book__share/views/book_details.dart';
import 'package:book__share/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyrequestsPage extends StatefulWidget {
  const MyrequestsPage({super.key});

  @override
  State<MyrequestsPage> createState() => _MyrequestsPageState();
}

class _MyrequestsPageState extends State<MyrequestsPage> {


  final MyRequestController _myRequestController = MyRequestController();
 
  bool isLoading = true;
  String? ip;
  String? user_id;
  List<WishListModel> filteredBooks = [];

  // Fetch IP and User ID from SharedPreferences
  Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    user_id = prefObj.getString('uid')?.trim();

  print(ip);


    await fetchData();
  }

  // Fetch Wishlist data from the database
  Future<void> fetchData() async {
    try {
      await _myRequestController.fetchrequests();
      setState(() {
        // You can filter books here if needed
      });
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

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My requests'),
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
                : _myRequestController.myRequestList.isEmpty
                    ? const Center(
                        child: Text(
                          "No books available.",
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          crossAxisSpacing: 16, // Spacing between columns
                          mainAxisSpacing: 16, // Spacing between rows
                          childAspectRatio:
                              0.68, // Aspect ratio of each grid item
                        ),

                        itemCount: _myRequestController.myRequestList.length,
                        itemBuilder: (context, index) {
                          MyRequestsModel myRequestsModel =
                              _myRequestController.myRequestList[index];


  print('http://$ip/bookshare/uploads/${myRequestsModel.image}');
  print(myRequestsModel.title);

                          return GestureDetector(
                              onTap: () {
                            
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetailedView(
                                     
                            //          bid: myRequestsModel.bid, 
                            //          title: myRequestsModel.title, 
                            //          author: myRequestsModel.author, 
                            //          genre: myRequestsModel.genre,
                            //          description: myRequestsModel.description,
                                 
                            //          image: myRequestsModel.image, 
                            //          ownerId: myRequestsModel.ownerId, 
                            //         //  status: myRequestsModel.myRequestsModel
                                     
                            //          )));
                          },
                            child: Container(
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
                                    const Spacer(),
                                    Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "http://$ip/bookshare/uploads/${myRequestsModel.image}",
                                          ),fit: BoxFit.fitHeight
                                        ),
                                      ),
                                      
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: Text(
                                        myRequestsModel.title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text(wishListModel.genre),
                                       
                                    //   ],
                                    // ),
                                    Text(myRequestsModel.author),
                                   
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  8.0),
                                     child: Center(child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: themecolor
                                      ),
                                      onPressed: (){}, child: Text('REQUESTED', style: TextStyle(color: Colors.white),))),
                                   )
                                  ],
                                ),
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
