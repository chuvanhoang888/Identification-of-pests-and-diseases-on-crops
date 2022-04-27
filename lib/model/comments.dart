class Comments {
  late String postKey;
  late String commentKey;
  late String content;
  late String userId;
  late String userImg;
  late String userName;
  late String timeAgo;
  late List<String> likes;
  late List<String> dislikes;
  Comments({
    required this.postKey,
    required this.commentKey,
    required this.content,
    required this.userId,
    required this.userImg,
    required this.userName,
    required this.timeAgo,
    required this.likes,
    required this.dislikes,
  });
  //sending data to firebase
  Map<String, dynamic> toMap() {
    return {
      'postKey': postKey,
      'commentKey': commentKey,
      'content': content,
      'userId': userId,
      'userImg': userImg,
      'userName': userName,
      'timeAgo': timeAgo,
      'likes': likes,
      'dislikes': dislikes
    };
  }

  Comments.fromValues(var json) {
    postKey = json['postKey'];
    commentKey = json['commentKey'];
    content = json['content'];
    userId = json['userId'];
    userImg = json['userImg'];
    userName = json['userName'];
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
  }
}
