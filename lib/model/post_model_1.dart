class Post {
  late String postKey;
  late String title;
  late String content;
  late List<String> images;
  late String userId;
  late String userName;
  late String userPhoto;
  late String timeAgo;
  late List<String> likes;
  late List<String> dislikes;
  late int comments;
  late int shares;
  late int idCategories;
  late String nameCategories;
  late String idDisease;
  late String nameDisease;

  Post(
      {required this.postKey,
      required this.title,
      required this.content,
      required this.images,
      required this.userId,
      required this.userName,
      required this.userPhoto,
      required this.timeAgo,
      required this.likes,
      required this.dislikes,
      required this.comments,
      required this.shares,
      required this.idCategories,
      required this.nameCategories,
      required this.idDisease,
      required this.nameDisease});

  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'postKey': postKey,
      'title': title,
      'content': content,
      'images': images,
      'userId': userId,
      'userName': userName,
      'userPhoto': userPhoto,
      'timeAgo': timeAgo,
      'likes': likes,
      'dislikes': dislikes,
      'comments': comments,
      'shares': shares,
      'idCategories': idCategories,
      'nameCategories': nameCategories,
      'idDisease': idDisease,
      'nameDisease': nameDisease
    };
  }

  Post.fromValues(var json) {
    postKey = json['postKey'];
    title = json['title'];
    content = json['content'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(v);
      });
    }
    userId = json['userId'];
    userName = json['userName'];
    userPhoto = json['userPhoto'];
    timeAgo = json['timeAgo'];
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((l) {
        likes.add(l);
      });
    } else {
      likes = [];
    }
    if (json['dislikes'] != null) {
      dislikes = [];
      json['dislikes'].forEach((dl) {
        dislikes.add(dl);
      });
    } else {
      dislikes = [];
    }
    comments = json['comments'];
    shares = json['shares'];
    idCategories = json['idCategories'];
    nameCategories = json['nameCategories'];
    idDisease = json['idDisease'];
    nameDisease = json['nameDisease'];
  }
}

// class Images {
//   late String src;
//   Images({required this.src});

//   Images.fromJson(Map<String, dynamic> json) {
//     return json['images'];
//   }
// }

// class Images {
//   late List<String> src;

//   Images({required this.src});

//   Map<String, dynamic> imagesTomap() {
    
//     return {'src': src};
//   }
// }
