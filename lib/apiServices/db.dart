import 'package:firebase_database/firebase_database.dart';
import 'package:project_detect_disease_datn/model/comments.dart';
import 'package:project_detect_disease_datn/model/post_model_1.dart';

class DBServices {
  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Posts");
  final DatabaseReference comment =
      FirebaseDatabase.instance.reference().child("Comments");

  Future<bool> updatePosts(Post post) async {
    try {
      await database.child(post.postKey).update(post.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePosts(String postKey) async {
    try {
      await database.child(postKey).remove();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateComment(Comments comments) async {
    try {
      await comment
          .child(comments.postKey)
          .child(comments.commentKey)
          .update(comments.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
