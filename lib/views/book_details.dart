import 'dart:convert';

import 'package:book__share/constants/constants.dart';
import 'package:book__share/views/feedbackpage.dart';
import 'package:book__share/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BookDetailedView extends StatefulWidget {

  String ips;
    String userId;
    String userName;
    String userUsername;
    String userClass;
    String userContact;
    String userEmail;
    String bid;
    String title;
    String genre;
    String author;
    String description;
    String image;
    String ownerId;
    String status;
    String  feedback ;

   BookDetailedView({Key? key , 
   

        required this.ips,
         required this.userId,
        required this.userName,
        required this.userUsername,
        required this.userClass,
        required this.userContact,
        required this.userEmail,
        required this.bid,
        required this.title,
        required this.genre,
        required this.author,
        required this.description,
        required this.image,
        required this.ownerId,
        required this.status,
        required  this.feedback ,       
       }) :super(key:key);

  @override
  State<BookDetailedView> createState() => _BookDetailedViewState();
}

class _BookDetailedViewState extends State<BookDetailedView> {
    String? ip;
 String? URL;
  String? uid ;
        @override
  void initState() {
    super.initState();
   fetchIp();
  //  print(widget.userId);

  //  print( "http://${widget.ips}/bookshare/uploads/${widget.image}");

   String URL="http://${widget.ips}/bookshare/uploads/${widget.image}";
   print(URL);
  }



Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    uid = prefObj.getString('uid')?.trim();
    print(ip);


    // await fetchData();
  }

   late String url = "http://$ip/bookshare/book_request.php";


 Future <void> booking(String book_id , String owner_id) async {
  var response = await http.post(Uri.parse(url),
    body: {
          "book_id":book_id,
          "user_id":uid,
          "owner_id":owner_id


    }
    
    );
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success'){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succesfully booked")));
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Failed")));
    }



  }
  
  Future<void> _makeCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone call')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: themecolor,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        
            Container(
              height: 400,
              color: themecolor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        
                     Image.network(
                      height: 250,
                      "http://${widget.ips}/bookshare/uploads/${widget.image}",
          errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.wifi_off_rounded); // Replace with your fallback image path
          },
        )
        ,
                      SizedBox(height: 10,),
                
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.title! , style: TextStyle( 
                                                  color: Colors.white,
                                                   fontWeight: FontWeight.bold,
                                                   fontSize: 24),),
                          
                            // Spacer(),
                          
                            //                        Icon(Icons.star, color: Colors.yellow,)
                          
                          
                            ],
                          ),
        
                              Text(widget.author! , style: TextStyle( 
                                              color: Colors.white,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 18),),
                        ],
                      )
                  ],
                ),
              ),
            ),
        
            SizedBox(height: 10,),
        
         Padding(
           padding: const EdgeInsets.all(16.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Text(widget.genre! , style: TextStyle( 
                                                color: themecolor,
                                                 fontWeight: FontWeight.bold,
                                                 fontSize: 18),),
           
                                                   Padding(
                                                     padding: const EdgeInsets.all(8.0),
                                                     child: Text(widget.status! , style: TextStyle( 
                                                                                                   color: themecolor,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                    fontSize: 18),),
                                                   ),
           
           
            ],
           ),
         ),  
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:  16.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text(widget.description! , style: TextStyle( 
                                                    color: Colors.black,
                                                     fontWeight: FontWeight.normal,
                                                     fontSize: 14),),
               ],
             ),
           ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
             padding: const EdgeInsets.symmetric(horizontal:  16.0),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(widget.userName! , style: TextStyle( 
                                                    color: Colors.black,
                                                     fontWeight: FontWeight.normal,
                                                     fontSize: 14),),
        
        
                                                       Text(widget.userClass! , style: TextStyle( 
                                                    color: Colors.black,
                                                     fontWeight: FontWeight.normal,
                                                     fontSize: 14),),
               ],
             ),
           ),
            Padding(
             padding: const EdgeInsets.symmetric(horizontal:  16.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text(widget.userContact! , style: TextStyle( 
                                                    color: Colors.black,
                                                     fontWeight: FontWeight.normal,
                                                     fontSize: 14),),
                                                     SizedBox(width: 10,),
                CircleAvatar(child: IconButton(
                  onPressed: () {
                    _makeCall(widget.userContact!);
                  },
                  icon: Icon(Icons.phone))) 
               ],
             ),
           ),
        
        
          ],
        ),
        Text(widget.feedback ?? "" , style: TextStyle(color: Colors.black),),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
            
              Container(
                height: 45,
                width: double.infinity,
                child: FloatingActionButton(
                  isExtended: true,
                  backgroundColor: themecolor,
                  onPressed: () {
              
                   booking(widget.bid!, widget.ownerId!);
                  print('pressed');
                  },
                  child: Text(
                    'RESOURCE',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),

              TextButton(
                   onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> 
                    FeedbackPage(
                        bood_id: widget.bid!,
                        title: widget.title!,
                         author: widget.author!,
                        owner_id: widget.ownerId!,
                         )));
                   },
                    child: Text('Feedback'))
            ],
          ),
        ),

        
        
  
    );
  }
  

}