
class BooksviewModel {
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
    String feedback; 

    BooksviewModel({
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
        required this.feedback
    });

    factory BooksviewModel.fromJson(Map<String, dynamic> json) => BooksviewModel(
        userId: json["user_id"],
        userName: json["user_name"],
        userUsername: json["user_username"],
        userClass: json["user_class"],
        userContact: json["user_contact"],
        userEmail: json["user_email"],
        bid: json["bid"],
        title: json["title"],
        genre: json["genre"],
        author: json["author"],
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
        status: json["status"],
        feedback: json["feedback"] ?? "",
    );

}






class AllbooksModel {
  String bid;
  String title;
  String author;
  String genre;
  String description;
  String image;
  String price;
  String ownerId;
  String status;


  AllbooksModel({
    required this.bid,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.image,
    required this.price,
    required this.ownerId,
    required this.status,
  });

  factory AllbooksModel.fromJson(Map<String, dynamic> json) => AllbooksModel(
        bid: json["bid"] ?? '',
        title: json["title"] ?? '',
        author: json["author"] ?? '',
        genre: json["genre"] ?? '',
        description: json["description"] ?? '',
        image: json["image"] ?? '',
        price: json["price"] ?? '',
        ownerId: json["owner_id"] ?? '',
        status: json["status"] ?? '',
      );
}

class WishListModel {
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;
    String status;
    String userId;
    String userName;
    String userUsername;
    String userClass;
    String userContact;
    String userEmail;
    String feedback ;

    WishListModel({
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
        required this.status,
        required this.userId,
        required this.userName,
        required this.userUsername,
        required this.userClass,
        required this.userContact,
        required this.userEmail,
        required this.feedback

    });

    factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        bid: json["bid"],
        title: json["title"],
        author: json["author"],
        genre: json["genre"],
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
        status: json["status"],
        userId: json["user_id"],
        userName: json["user_name"],
        userUsername: json["user_username"],
        userClass: json["user_class"],
        userContact: json["user_contact"],
        userEmail: json["user_email"],
           feedback: json["feedback"],
    );
}

// class WishListModel {
//     String bid;
//     String title;
//     String author;
//     String genre;
//     String description;
//     String image;
//     String ownerId;
//     String status ;

//     WishListModel({
//         required this.bid,
//         required this.title,
//         required this.author,
//         required this.genre,
//         required this.description,
//         required this.image,
//         required this.ownerId,
//         required this.status,
//     });

//     factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
//         bid: json["bid"] ??"",
//         title: json["title"]??"",
//         author: json["author"]??"",
//         genre: json["genre"]??"",
//         description: json["description"]??"",
//         image: json["image"]??"",
//         ownerId: json["owner_id"]??"",
//         status: json["status"] ??"",
//     );
// }


class MybooksModel {
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;
    String status;

    MybooksModel({
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
        required this.status,
    });

    factory MybooksModel.fromJson(Map<String, dynamic> json) => MybooksModel(
        bid: json["bid"],
        title: json["title"],
        author: json["author"],
        genre: json["genre"],
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
        status: json["status"],
    );
}


class RequestArrivedModel {
  String bid;
  String title;
  String author;
  String genre;
  String description;
  String image;
  String ownerId;
  String name;
  String username;
  String contact;
  String email;
  String datumClass;
  String id;
  String status;

  RequestArrivedModel({
    required this.bid,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.image,
    required this.ownerId,
    required this.name,
    required this.username,
    required this.contact,
    required this.email,
    required this.datumClass,
    required this.id,
    required this.status,
  });

  factory RequestArrivedModel.fromJson(Map<String, dynamic> json) => RequestArrivedModel(
    bid: json["bid"] ?? '',
    title: json["title"] ?? '',
    author: json["author"] ?? '',
    genre: json["genre"] ?? '',
    description: json["description"] ?? '',
    image: json["image"] ?? '',
    ownerId: json["owner_id"] ?? '',
    name: json["name"] ?? '',
    username: json["username"] ?? '',
    contact: json["contact"] ?? '',
    email: json["email"] ?? '',
    datumClass: json["class"] ?? '',
    id: json["id"] ?? '',
    status: json["status"] ?? '',
  );
}


class BooksinHandModel {
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;
    String returndate;

    BooksinHandModel({
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
        required this.returndate,
    });

    factory BooksinHandModel.fromJson(Map<String, dynamic> json) => BooksinHandModel(
        bid: json["bid"]??"",
        title: json["title"]??"",
        author: json["author"]??"",
        genre: json["genre"]??"",
        description: json["description"]??"",
        image: json["image"]??"",
        ownerId: json["owner_id"]??"",
        returndate: json["return_date"]??"",
    );

}





class MyRequestsModel {
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;

       MyRequestsModel ({
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
    });

    factory MyRequestsModel.fromJson(Map<String, dynamic> json) => MyRequestsModel(
        bid: json["bid"] ,
        title: json["title"],
        author: json["author"] ,
        genre: json["genre"]  ,
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
    );

}



class BooksGivenModel {
    String returnDate;
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;
    String status;
    String name;
    String username;
    String contact;
    String email;
    String datumClass;
    String id;

    BooksGivenModel({
        required this.returnDate,
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
        required this.status,
        required this.name,
        required this.username,
        required this.contact,
        required this.email,
        required this.datumClass,
        required this.id,
    });

    factory BooksGivenModel.fromJson(Map<String, dynamic> json) => BooksGivenModel(
        returnDate:json["return_date"],
        bid: json["bid"],
        title: json["title"],
        author: json["author"],
        genre: json["genre"],
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
        status: json["status"],
        name: json["name"],
        username: json["username"],
        contact: json["contact"],
        email: json["email"],
        datumClass: json["class"],
        id: json["id"],
    );
}



class HistoryModel {
    String bid;
    String title;
    String author;
    String genre;
    String description;
    String image;
    String ownerId;

    HistoryModel({
        required this.bid,
        required this.title,
        required this.author,
        required this.genre,
        required this.description,
        required this.image,
        required this.ownerId,
    });

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        bid: json["bid"],
        title: json["title"],
        author: json["author"],
        genre: json["genre"],
        description: json["description"],
        image: json["image"],
        ownerId: json["owner_id"],
    );
}


class ProfileModel {
    String id;
    String name;
    String username;
    String profileModelClass;
    String contact;
    String email;
    String password;

    ProfileModel({
        required this.id,
        required this.name,
        required this.username,
        required this.profileModelClass,
        required this.contact,
        required this.email,
        required this.password,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        profileModelClass: json["class"],
        contact: json["contact"],
        email: json["email"],
        password: json["password"],
    );
}


class NewsModel {
    String id;
    String news;

    NewsModel({
        required this.id,
        required this.news,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        news: json["news"],
    );
}