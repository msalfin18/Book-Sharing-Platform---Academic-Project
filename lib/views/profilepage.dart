import 'package:book__share/constants/constants.dart';
import 'package:book__share/views/books_given.dart';
import 'package:book__share/views/booksinhand.dart';
import 'package:book__share/views/feedbackpage.dart';
import 'package:book__share/views/history.dart';
import 'package:book__share/views/login.dart';
import 'package:book__share/views/mybooks.dart';
import 'package:book__share/views/myrequests.dart';
import 'package:book__share/views/requests_arrived.dart';
import 'package:book__share/views/userprofile.dart';
import 'package:book__share/views/wishlist.dart';
import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: themecolor,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [

            Card(
               shadowColor: themecolor,
                      elevation: 10,
               child: ListTile(
                title: Text('My Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UserProfile()));
                },
                           ),
             ),
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                },
                           ),
             ),
        
          ],
        ),
      )
    );
  }
}