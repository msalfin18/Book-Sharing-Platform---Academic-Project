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

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistController _wishlistController = WishlistController();
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  String? ip;
  String? user_id;
  List<WishListModel> filteredBooks = [];

  // Fetch IP and User ID from SharedPreferences
  Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    user_id = prefObj.getString('uid')?.trim();

    await fetchData();
  }

  // Fetch Wishlist data from the database
Future<void> fetchData() async {
  try {
    await _wishlistController.fetchrequests();
    setState(() {
      filteredBooks = List.from(_wishlistController.wishlistList);
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


  // Add book to wishlist
  late String fav_url = "http://$ip/bookshare/remove_wish.php";

  void remove_from_fav(
    String book_id,
  ) async {
    var response = await http.post(Uri.parse(fav_url), body: {
      "book_id": book_id,
    });

    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Successfully removed from wishlist")),
      );
      setState(() {});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add to wishlist")),
      );
    }
  }

  // Filter books based on search query
void filterBooks(String query) {
  setState(() {
    if (query.isEmpty) {
      filteredBooks = List.from(_wishlistController.wishlistList);
    } else {
      filteredBooks = _wishlistController.wishlistList.where((book) {
        return book.title.toLowerCase().contains(query.toLowerCase()) ||
            book.author.toLowerCase().contains(query.toLowerCase()) ||
            book.genre.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  });
}


 @override
void initState() {
  super.initState();
  fetchIp().then((_) {
    _searchController.addListener(() {
      if (_wishlistController.wishlistList.isNotEmpty) {
        filterBooks(_searchController.text);
      }
    });
  });
}

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: Center(
                  child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 34,
              )),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Top Container
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(color: themecolor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BOOK SHARE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 27),
                    child: Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Container(
                        height: 43,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  left: 20, bottom: 0, top: 7),
                              hintText: 'What are you looking for?',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.7)),
                              prefixIcon: Icon(
                                Icons.search,
                                color: themecolor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : filteredBooks.isEmpty
                    ? const Center(
                        child: Text(
                          "No books available.",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
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
                        itemCount: filteredBooks.length,
                        itemBuilder: (context, index) {
                          WishListModel wishListModel = filteredBooks[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookDetailedView(
                                        ips: ip!,
                                          userId:  wishListModel.userId,
                                          userName: wishListModel. userName,
                                          userUsername: wishListModel. userUsername,
                                          userClass: wishListModel. userClass,
                                          userContact: wishListModel. userContact,
                                          userEmail: wishListModel. userEmail,
                                          bid:  wishListModel.bid,
                                          title: wishListModel. title,
                                          genre: wishListModel. genre,
                                          author: wishListModel. author,
                                          description: wishListModel. description,
                                          image:  wishListModel.image,
                                          ownerId: wishListModel. ownerId,
                                          status: wishListModel. status,
                                          feedback: wishListModel.feedback ?? "",
                                            )));
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
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            "http://$ip/bookshare/uploads/${wishListModel.image}",
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                remove_from_fav(
                                                    wishListModel.bid);
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: Text(
                                        wishListModel.title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(wishListModel.genre),
                                        const Spacer(),
                                      ],
                                    ),
                                    Text(wishListModel.author),
                                    const Spacer(),
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