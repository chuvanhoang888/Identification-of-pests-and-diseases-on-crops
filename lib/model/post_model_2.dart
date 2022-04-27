import 'package:project_detect_disease_datn/model/use.dart';

class Post {
  final User user;
  final String caption;
  final String timeAgo;
  final String imageUrl;
  final int idDease;
  final int likes;
  final int comments;
  final int shares;

  const Post({
    required this.user,
    required this.caption,
    required this.timeAgo,
    required this.imageUrl,
    required this.idDease,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
