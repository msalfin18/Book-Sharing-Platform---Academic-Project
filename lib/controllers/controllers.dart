import 'dart:convert';

import 'package:book__share/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class BooksHomeController {
  List<BooksviewModel> bookshomelist = [];

  Future<void> fetchrequests() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


    final urlw = Uri.parse('http://$ip/bookshare/book_view_home.php?owner_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          bookshomelist = (decodedData['data'] as List)
              .map<BooksviewModel>((json) => BooksviewModel.fromJson(json))
              .toList();
        } else {
          bookshomelist = [
            BooksviewModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}



// class BooksHomeController {
  
//   List<BooksviewModel> bookshomelist = [];

//   Future<void> fetchbookshome() async {

//    SharedPreferences prefObj = await SharedPreferences.getInstance();
//     String? ip = prefObj.getString('ip')?.trim();
//       String? _uid = prefObj.getString('uid')?.trim();

//     if (ip == null || ip.isEmpty) {
//       print("IP address not found in SharedPreferences");
//       return  ;
//     }
//     final url = Uri.parse('http://$ip/bookshare/book_view_home.php?owner_id=$_uid');

//     try {
//       print(url);
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('20000000000000000000000000000000000000000');
//         final decodedData = jsonDecode(response.body);
//         print(response.body);

//         if (decodedData is List) {
//           bookshomelist = decodedData.map<BooksviewModel>((i) => BooksviewModel.fromJson(i)).toList();
//         } else {
//           bookshomelist = [BooksviewModel.fromJson(decodedData)];
//         }
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
// }

class AllbooksController {

  List<BooksviewModel> allbooksList= [];

  Future<void> fetchrequests() async {

    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


    final urlw = Uri.parse('http://$ip/bookshare/books_view.php?owner_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          allbooksList = (decodedData['data'] as List)
              .map<BooksviewModel>((json) => BooksviewModel.fromJson(json))
              .toList();
        } else {
          allbooksList = [
            BooksviewModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}



// class AllbooksController {
//   List<AllbooksModel> allbookslist = [];

//   Future<void> fetchallbooks() async {

//    SharedPreferences prefObj = await SharedPreferences.getInstance();
//     String? ip = prefObj.getString('ip')?.trim();
//       String? _uid = prefObj.getString('uid')?.trim();

//     if (ip == null || ip.isEmpty) {
//       print("IP address not found in SharedPreferences");
//       return  ;
//     }
//     final url = Uri.parse('http://$ip/bookshare/books_view.php?owner_id=$_uid');

//     try {
//       print(url);
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('20000000000000000000000000000000000000000');
//         final decodedData = jsonDecode(response.body);
//         print(response.body);

//         if (decodedData is List) {
//           allbookslist = decodedData.map<AllbooksModel>((i) => AllbooksModel.fromJson(i)).toList();
//         } else {
//           allbookslist = [AllbooksModel.fromJson(decodedData)];
//         }
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
// }





class WishlistController {
  
  List<WishListModel> wishlistList= [];

  Future<void> fetchrequests() async {

    SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


    final urlw = Uri.parse('http://$ip/bookshare/wishlist_view.php?user_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          wishlistList = (decodedData['data'] as List)
              .map<WishListModel>((json) => WishListModel.fromJson(json))
              .toList();
        } else {
          wishlistList = [
            WishListModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}



// class WishlistController {
//   List<WishListModel>  wishlistList = [];

//   Future<void> fetchDatabase() async {
//     try {
//       SharedPreferences prefObj = await SharedPreferences.getInstance();
//       String? ip = prefObj.getString('ip')?.trim();
//     String? _uid = prefObj.getString('uid')?.trim();


//       if (ip == null || ip.isEmpty) {
//         print("IP address not found in SharedPreferences");
//         return;
//       }

//       final url = Uri.parse('http://$ip/bookshare/wishlist_view.php?user_id=$_uid');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         print(url);
//         final Map<String, dynamic> data = json.decode(response.body);
//         final List<dynamic> wishlistData = data['data'];

//         wishlistList = wishlistData
//             .map((i) => WishListModel.fromJson(i))
//             .toList();
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('An error occurred: $e');
//     }
//   }
// }


class MybooksController {
  List<MybooksModel> mybookslist = [];

  Future<void> fetchmybooks() async {

   SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return  ;
    }
    final url = Uri.parse('http://$ip/bookshare/mybooks.php?owner_id=$_uid');

    try {
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('20000000000000000000000000000000000000000');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          mybookslist = decodedData.map<MybooksModel>((i) => MybooksModel.fromJson(i)).toList();
        } else {
          mybookslist = [MybooksModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




// class RequestArrivedController {
//   List<RequestArrivedModel> requestarrivedList = [];

//   Future<void> fetchrequests() async {

//    SharedPreferences prefObj = await SharedPreferences.getInstance();
//     String? ip = prefObj.getString('ip')?.trim();
//     String? _uid = prefObj.getString('uid')?.trim();

//     if (ip == null || ip.isEmpty) {
//       print("IP address not found in SharedPreferences");
//       return  ;
//     }
//     final url = Uri.parse('http://$ip/bookshare/request_arrived.php?owner_id=$_uid');

//     try {
//       print(url);
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('20000000000000000000000000000000000000000');
//         final decodedData = jsonDecode(response.body);
//         print(response.body);

//         if (decodedData is List) {
//           requestarrivedList = decodedData.map<RequestArrivedModel>((i) => RequestArrivedModel.fromJson(i)).toList();
//         } else {
//           requestarrivedList = [RequestArrivedModel.fromJson(decodedData)];
//         }
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }


// }


class RequestArrivedController {
  List<RequestArrivedModel> requestarrivedList = [];

  Future<void> fetchrequests() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


    final urlw = Uri.parse('http://$ip/bookshare/request_arrived.php?owner_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          requestarrivedList = (decodedData['data'] as List)
              .map<RequestArrivedModel>((json) => RequestArrivedModel.fromJson(json))
              .toList();
        } else {
          requestarrivedList = [
            RequestArrivedModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}



// class BooksinHandController {
//   List<BooksinHandModel> booksinhandList = [];

//   Future<void> fetchDatabase() async {

//    SharedPreferences prefObj = await SharedPreferences.getInstance();
//     String? ip = prefObj.getString('ip')?.trim();
//     String? _uid = prefObj.getString('uid')?.trim();

//     if (ip == null || ip.isEmpty) {
//       print("IP address not found in SharedPreferences");
//       return  ;
//     }
//     final url = Uri.parse('http://$ip/bookshare/books_inhand.php?user_id=$_uid');

//     try {
//       print(url);
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('20000000000000000000000000000000000000000');
//         final decodedData = jsonDecode(response.body);
//         print(response.body);

//         if (decodedData is List) {
//           booksinhandList = decodedData.map<BooksinHandModel>((i) => BooksinHandModel.fromJson(i)).toList();
//         } else {
//           booksinhandList = [BooksinHandModel.fromJson(decodedData)];
//         }
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
// }

class BooksinHandController {
  List<BooksinHandModel> booksinhandList = [];

  Future<void> fetchrequests() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


  final urlw = Uri.parse('http://$ip/bookshare/books_inhand.php?user_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       
       print(response.body);

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          booksinhandList = (decodedData['data'] as List)
              .map<BooksinHandModel>((json) => BooksinHandModel.fromJson(json))
              .toList();
        } else {
          booksinhandList = [
            BooksinHandModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}


class MyRequestController {
  List<MyRequestsModel> myRequestList = [];

  Future<void> fetchrequests() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


  final urlw = Uri.parse('http://$ip/bookshare/my_requests.php?user_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       
       print(response.body);

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          myRequestList = (decodedData['data'] as List)
              .map<MyRequestsModel>((json) => MyRequestsModel.fromJson(json))
              .toList();
        } else {
          myRequestList = [
            MyRequestsModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




// class MyRequestController {
//   List<MyRequestsModel> myRequestList = [];

//   Future<void> fetchDatabase() async {

//    SharedPreferences prefObj = await SharedPreferences.getInstance();
//     String? ip = prefObj.getString('ip')?.trim();
//     String? _uid = prefObj.getString('uid')?.trim();

//     if (ip == null || ip.isEmpty) {
//       print("IP address not found in SharedPreferences");
//       return  ;
//     }
//     final url = Uri.parse('http://$ip/bookshare/my_requests.php?user_id=$_uid');

//     try {
//       print(url);
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         print('20000000000000000000000000000000000000000');
//         final decodedData = jsonDecode(response.body);
//         print(response.body);

//         if (decodedData is List) {
//           myRequestList = decodedData.map<MyRequestsModel>((i) => MyRequestsModel.fromJson(i)).toList();
//         } else {
//           myRequestList = [MyRequestsModel.fromJson(decodedData)];
//         }
//       } else {
//         print("Failed to load data: ${response.statusCode}");
//       }
//     } catch (error) {
//       print("Error: $error");
//     }
//   }
// }





class BooksGivenController {
  List< BooksGivenModel> booksgivenList = [];

  Future<void> fetchDatabase() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


  final urlw = Uri.parse('http://$ip/bookshare/books_given.php?owner_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       
       print(response.body);

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          booksgivenList = (decodedData['data'] as List)
              .map<BooksGivenModel>((json) => BooksGivenModel.fromJson(json))
              .toList();
        } else {
          booksgivenList = [
            BooksGivenModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




class HistoryController {
  List< HistoryModel> historyList = [];

  Future<void> fetchDatabase() async {
       SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();


  final urlw = Uri.parse('http://$ip/bookshare/history.php?user_id=$_uid');

    try {
      final response = await http.get(urlw);
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
       
       print(response.body);

        // Access the 'data' key in the decoded JSON
        if (decodedData['data'] is List) {
      
          historyList = (decodedData['data'] as List)
              .map<HistoryModel>((json) => HistoryModel.fromJson(json))
              .toList();
        } else {
          historyList = [
            HistoryModel.fromJson(decodedData['data'])
          ];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}





class ProfileController {
  List<ProfileModel> ProfileList = [];

  Future<void> fetchData() async {

   SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return  ;
    }
    final url = Uri.parse('http://$ip/bookshare/user_profile.php?user_id=$_uid');

    try {
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('20000000000000000000000000000000000000000');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          ProfileList = decodedData.map<ProfileModel>((i) => ProfileModel.fromJson(i)).toList();
        } else {
          ProfileList = [ProfileModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}




class NewsController {
  List<NewsModel> newsList = [];

  Future<void> fetchnews() async {

   SharedPreferences prefObj = await SharedPreferences.getInstance();
    String? ip = prefObj.getString('ip')?.trim();
    String? _uid = prefObj.getString('uid')?.trim();

    if (ip == null || ip.isEmpty) {
      print("IP address not found in SharedPreferences");
      return  ;
    }
    final url = Uri.parse('http://$ip/bookshare/news.php');

    try {
      print(url);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('20000000000000000000000000000000000000000');
        final decodedData = jsonDecode(response.body);
        print(response.body);

        if (decodedData is List) {
          newsList = decodedData.map<NewsModel>((i) => NewsModel.fromJson(i)).toList();
        } else {
          newsList = [NewsModel.fromJson(decodedData)];
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}