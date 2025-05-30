import 'package:book__share/constants/constants.dart';
import 'package:book__share/controllers/controllers.dart';
import 'package:book__share/models/models.dart';
import 'package:book__share/views/books_given.dart';
import 'package:book__share/views/booksinhand.dart';
import 'package:book__share/views/history.dart';
import 'package:book__share/views/login.dart';
import 'package:book__share/views/mybooks.dart';
import 'package:book__share/views/myrequests.dart';
import 'package:book__share/views/requests_arrived.dart';
import 'package:book__share/views/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
   UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
   final ProfileController _profileController = ProfileController();

    bool isLoading = true;

  String? ip;

  String? user_id;

  // Fetch IP and User ID from SharedPreferences
  Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    user_id = prefObj.getString('uid')?.trim();

    await fetchData();
  }

  // Fetch Wishlist data from the database
  Future<void> fetchData() async {

      await _profileController.fetchData();
      setState(() {
        // You can filter books here if needed
      });
     
  }

  @override
  void initState() {
    super.initState();
    fetchIp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: themecolor,),
            body: ListView.builder(
                    
                  itemCount: _profileController.ProfileList.length,
                        itemBuilder: (context, index) {
                          ProfileModel profileModel =
                              _profileController.ProfileList[index];
                
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            child: Text('${profileModel.name[0].toUpperCase()}', style: const TextStyle(fontSize: 50),),
                          ),
                        ),
                                    
                         SizedBox(height: 10,),
                        Text(profileModel.name, style:  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    
                        Text(profileModel.email, style: const TextStyle(fontSize: 20),),
                        // const SizedBox(height: 10,),
                         Text(profileModel.contact, style: const TextStyle(fontSize: 16),),
                        // Text(profileModel., style: const TextStyle(fontSize: 16),),
                    const SizedBox(height: 30,),
                       Card(
                      shadowColor: themecolor,
                      elevation: 10,
              child: ListTile(
                title: Text('Wishlist'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> WishlistPage()));
                },
              ),
            ),
  Card(
        shadowColor: themecolor,
                      elevation: 10,
              child: ListTile(
                title: Text('Requests Arrived'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> RequestsArrivedPage()));
                },
              ),
            ),
             Card(
                  shadowColor: themecolor,
                      elevation: 10,
              child: ListTile(
                title: Text('My books'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MybooksPage()));
                },
              ),
            ),

              Card(
                    shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('My Requests'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyrequestsPage()));
                },
                           ),
             ),
        
             
            
             Card(
                  shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('Books in hand'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BooksInHand()));
                },
                           ),
             ),

             Card(
                  shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('Books Given'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> BooksGivenPage()));
                },
                           ),
             ),
        
            //  Card(
            //    child: ListTile(
            //     title: Text('Feedback'),
            //     onTap: () {
            //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> ));
            //     },
            //                ),
            //  ),
        
            
             Card(
                  shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('History'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryPage()));
                },
                           ),
             ),
              Card(
                    shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('Logout'),
                onTap: () {
               Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => LoginPage()),
  (route) => false, // This removes all previous routes
);

                },
                           ),
             ),
                      ],),
                  ),
                );

                        }
                     
                     )
    );
  }
}