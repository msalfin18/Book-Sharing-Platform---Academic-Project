import 'dart:convert';
import 'package:marquee/marquee.dart';
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

class Homepage extends StatefulWidget {
  final String? name;

  Homepage({Key? key, this.name}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final BooksHomeController _booksHomeController = BooksHomeController();
  final NewsController _newsController = NewsController();

  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      await _booksHomeController.fetchrequests();
      await _newsController.fetchnews();
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

  late String fav_url = "http://$ip/bookshare/add_wishlist.php";

  void add_to_fav(
    String book_id,
    String user_id,
    String owner_id,
  ) async {
    var response = await http.post(Uri.parse(fav_url), body: {
      "book_id": book_id,
      "user_id": user_id,
      "owner_id": owner_id,
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Succesfully registed")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registartion Failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themecolor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profilepage()));
              },
              child: CircleAvatar(
                child: Center(
                  child: Icon(Icons.person)
                ),

                radius: 20,
                backgroundColor: Colors.white,
                // backgroundImage: AssetImage('asset/person.jpg')
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                height: 30,
                width: 30,
                child: Center(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WishlistPage()));
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 34,
                        )))),
          )
        ],
      ),
      body: Column(
        children: [
          // Top Container
          Container(
            height: 30, // Fixed height for the news marquee
            child: ListView.builder(
              itemCount: _newsController.newsList.length,
              itemBuilder: (context, index) {
                NewsModel newsModel = _newsController.newsList[index];
                return SizedBox(
                  height: 30,
                  child: Marquee(
                    text: '${newsModel.news ?? "No Alerts"}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                );
              },
            ),
          ),
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
                  Text(
                    'Welcome To',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'RESOURCE SHARE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Rated',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllbooksPage()));
                    },
                    child: Text('see all',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: themecolor)))
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchData, // Callback to refresh data
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : _booksHomeController.bookshomelist.isEmpty
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
                          itemCount: _booksHomeController.bookshomelist.length,
                          itemBuilder: (context, index) {
                            BooksviewModel booksviewModel =
                                _booksHomeController.bookshomelist[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookDetailedView(
                                              ips: ip!,
                                              userId: booksviewModel.userId,
                                              userName: booksviewModel.userName,
                                              userUsername:
                                                  booksviewModel.userUsername,
                                              userClass: booksviewModel.userClass,
                                              userContact:
                                                  booksviewModel.userContact,
                                              userEmail: booksviewModel.userEmail,
                                              bid: booksviewModel.bid,
                                              title: booksviewModel.title,
                                              genre: booksviewModel.genre,
                                              author: booksviewModel.author,
                                              description:
                                                  booksviewModel.description,
                                              image: booksviewModel.image,
                                              ownerId: booksviewModel.ownerId,
                                              status: booksviewModel.status,
                                              feedback: booksviewModel.feedback,
                                            )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themecolor.withOpacity(0.1),
                                  border:
                                      Border.all(width: 2, color: themecolor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8, right: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Spacer(),
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            "http://$ip/bookshare/uploads/${booksviewModel.image}",
                                          )),
                                        ),
                                      ),
                                      Spacer(),
                                      Center(
                                        child: Text(
                                          booksviewModel.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            booksviewModel.genre,
                                          ),
                                        ],
                                      ),
                                      Text(booksviewModel.author),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddBooksPage()));
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