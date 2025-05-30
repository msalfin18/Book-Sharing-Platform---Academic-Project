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

class RequestsArrivedPage extends StatefulWidget {
  const RequestsArrivedPage({super.key});

  @override
  State<RequestsArrivedPage> createState() => _RequestsArrivedPageState();
}

class _RequestsArrivedPageState extends State<RequestsArrivedPage> {
  final RequestArrivedController _requestArrivedController = RequestArrivedController();

  bool isLoading = true;
  String? ip;
  String? user_id;
  // String? book_id;
  List<WishListModel> filteredBooks = [];

  String currentDate = DateTime.now().toLocal().toString().split(' ')[0]; 
String endDate = DateTime.now().add(Duration(days: 20)).toLocal().toString().split(' ')[0];


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
      await _requestArrivedController.fetchrequests();
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
// Add to booking function
void add_to_booking(BuildContext cntx , String id) async {
  if (id == null || ip == null) {
    ScaffoldMessenger.of(cntx).showSnackBar(const SnackBar(content: Text("Missing required information.")));
    return;
  }



 final url = "http://$ip/bookshare/accept_request.php";
final response = await http.post(Uri.parse(url), body: {
  "id": id,
  "accept_date": currentDate,
  "return_date": endDate,
});

 
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);
       

    if (jsonString == 'success') {


      changestatus(context, id); // Pass the context to changestatus
    } else {
      ScaffoldMessenger.of(cntx).showSnackBar(
        SnackBar(content: Text("Failed to add to booking table")),
      );
    }
  } else {
    ScaffoldMessenger.of(cntx).showSnackBar(
      SnackBar(content: Text("Error: ${response.statusCode}")),
    );
  }
}

// Change status function
void changestatus(BuildContext cntx ,String book_id) async {
  if (book_id == null || ip == null) {
    ScaffoldMessenger.of(cntx).showSnackBar(const SnackBar(content: Text("Missing required information.")));
    Navigator.pushReplacement(
        cntx,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );
    return;
  }

  final url = "http://$ip/bookshare/change_status.php?book_id=$book_id";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {
      ScaffoldMessenger.of(cntx).showSnackBar(
        const SnackBar(content: Text("Status updated successfully.")),
      
      );
      
      setState(() {
        
      });
      Navigator.pushReplacement(
        cntx,
        MaterialPageRoute(builder: (context) =>  Homepage()),
      );

    } else {
      ScaffoldMessenger.of(cntx).showSnackBar(
        const SnackBar(content: Text("Failed to update status.")),
      );
    }
  } else {
    ScaffoldMessenger.of(cntx).showSnackBar(
      SnackBar(content: Text("Error: ${response.statusCode}")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Arrived'),
        backgroundColor: themecolor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _requestArrivedController.requestarrivedList.isEmpty
                    ? const Center(
                        child: Text(
                          "No books available.",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of items per row
                          crossAxisSpacing: 16, // Spacing between columns
                          mainAxisSpacing: 16, // Spacing between rows
                          childAspectRatio: 0.68, // Aspect ratio of each grid item
                        ),
                        itemCount: _requestArrivedController.requestarrivedList.length,
                        itemBuilder: (context, index) {
                          print(_requestArrivedController.requestarrivedList.length);
                          RequestArrivedModel requestArrivedModel =
                              _requestArrivedController.requestarrivedList[index];
                              print(requestArrivedModel.id);

                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetailedView(
                              //          bid: requestArrivedModel.bid, 
                              //          title: requestArrivedModel.title, 
                              //          author: requestArrivedModel.author, 
                              //          genre: requestArrivedModel.genre,
                              //          description: requestArrivedModel.description,
                              //          image: requestArrivedModel.image, 
                              //          ownerId: requestArrivedModel.ownerId, 
                              //          status: requestArrivedModel.status
                              //          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: themecolor.withOpacity(0.1),
                                border: Border.all(width: 2, color: themecolor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
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
                                            "http://$ip/bookshare/uploads/${requestArrivedModel.image}",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Center(
                                      child: Text(
                                        requestArrivedModel.title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Text(requestArrivedModel.author),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: themecolor,
                                          ),
                                          onPressed: () {
                                         

                                            print("id: ${requestArrivedModel.id}");
                                            print('currentDate: $currentDate');
                                            print('endDate: $endDate');
                                            add_to_booking( context, requestArrivedModel.id);
                                            
                                          },
                                          child: const Text('Accept', style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
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
