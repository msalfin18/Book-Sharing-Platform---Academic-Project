import 'dart:convert';

import 'package:book__share/constants/constants.dart';
import 'package:book__share/views/feedbackpage.dart';
import 'package:book__share/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GivenBookDetails extends StatefulWidget {

     String? bid;
     String? booking_id;
    String? title;
    String? author;
    String? genre;
    String? description;
    String? image;
    String? ownerId;
    String? status ;
    String? return_date;
    String? name;
    String? contact;
  
    String? email;

   GivenBookDetails({Key? key , 
   
            this.bid,
            this.booking_id,
         this.title,
    
         this.author,
         this.genre,
         this.description,
         this.image,
         this.ownerId,
         this.status,
         this.contact,
         this.email,
         this.name,
          this.return_date,
     
         }) :super(key:key);

  @override
  State<GivenBookDetails> createState() => _GivenBookDetailsState();
}

class _GivenBookDetailsState extends State<GivenBookDetails> {
        @override
  void initState() {
    super.initState();
   fetchIp();
  }

  String? ip;

  String? uid ;

Future<void> fetchIp() async {
    SharedPreferences prefObj = await SharedPreferences.getInstance();
    ip = prefObj.getString('ip')?.trim();
    uid = prefObj.getString('uid')?.trim();


    // await fetchData();
  }




// Change status function
void changestatus(BuildContext cntx ,String booking_id) async {
  if (booking_id == null || ip == null) {
    ScaffoldMessenger.of(cntx).showSnackBar(const SnackBar(content: Text("Missing required information.")));
    return;
  }

  final url = "http://$ip/bookshare/book_given_mybooking.php?=$booking_id";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {

      ScaffoldMessenger.of(cntx).showSnackBar(
        const SnackBar(content: Text("Status updated on booking.")),
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
 



 

// Change status function
void changestatusonbooks() async {
  if (widget.bid == null || ip == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Missing required information.")));
    return;
  }

  final url = "http://$ip/bookshare/book_given_mybooking.php?=${widget.bid}";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    print(jsonString);

    if (jsonString == 'success') {
            changestatusonbooks();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Status updated on books.")),
      );
    
setState(() {
  
});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Homepage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update status.")),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${response.statusCode}")),
    );
  }
}     
 

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: themecolor,
      ),

      body: Column(
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
                      
                      Image(image: NetworkImage(
                        
                        "http://$ip/bookshare/uploads/${widget.image}",
                            //  'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSFXmE6cRQjMvHbAHU2HALzpQR7wVo48gzyrG6OWY5Si2tM3Qc1'                      
                        ),
                         width: double.infinity,
                         height: 250,
                         ),
              
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

                            Text(widget.name! , style: TextStyle( 
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
                Text(widget.contact! , style: TextStyle( 
                                              color: themecolor,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 18),),
         
                  
         
         
          ],
         ),
       ),  
         Padding(
           padding: const EdgeInsets.symmetric(horizontal:  16.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Text(widget.return_date! , style: TextStyle( 
                                                  color: Colors.red,
                                                   fontWeight: FontWeight.normal,
                                                   fontSize: 14),),
             ],
           ),
         ),

        ],
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
              
                    changestatus(context, widget.booking_id!);
                  print('pressed');
                  },
                  child: Text(
                    'RETURNED',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),

              
            ],
          ),
        ),

        
        
  
    );
  }
  

}