import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_detect_disease_datn/apiServices/db.dart';

import 'package:project_detect_disease_datn/model/comments.dart';

import 'package:project_detect_disease_datn/screens/communication/components/detail_posts.dart';
import 'package:project_detect_disease_datn/screens/communication/components/profile_avatar.dart';
import 'package:project_detect_disease_datn/size_config.dart';

class CommentsContainer extends StatefulWidget {
  final Comments comments;

  const CommentsContainer({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  _CommentsContainerState createState() => _CommentsContainerState();
}

class _CommentsContainerState extends State<CommentsContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(10),
        color: Color(0xFFEFF3F5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PostHeader(comments: widget.comments),
                const SizedBox(height: 10.0),
                // _PostDetect(post: post),
                Text(
                  widget.comments.content,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: _PostStats(comments: widget.comments),
          ),
          Container(
              decoration: BoxDecoration(color: Colors.white),
              child: SizedBox(
                width: double.infinity,
                height: 2,
              ))
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Comments comments;

  const _PostHeader({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: comments.userImg),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comments.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${comments.timeAgo} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          icon: const Icon(Icons.more_vert),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends StatefulWidget {
  final Comments comments;

  const _PostStats({
    Key? key,
    required this.comments,
  }) : super(key: key);

  @override
  State<_PostStats> createState() => _PostStatsState();
}

class _PostStatsState extends State<_PostStats> {
  final User? user = FirebaseAuth.instance.currentUser;
  Color likeColor = Color(0xFF627C8B);
  Color dislikeColor = Color(0xFF627C8B);
  Color basicColor = Color(0xFF627C8B);
  @override
  Widget build(BuildContext context) {
    if (widget.comments.likes.contains(user?.uid)) {
      setState(() {
        likeColor = Color(0xFF1EE4B1);
        dislikeColor = Color(0xFF627C8B);
      });
    } else if (widget.comments.dislikes.contains(user?.uid)) {
      setState(() {
        dislikeColor = Color(0xFFF95049);
        likeColor = Color(0xFF627C8B);
      });
    } else {
      setState(() {
        likeColor = Color(0xFF627C8B);
        dislikeColor = Color(0xFF627C8B);
      });
    }
    return Column(
      children: [
        const Divider(
          indent: 5,
          endIndent: 5,
          color: Colors.white,
          height: 20,
        ),
        // Container(
        //   decoration: BoxDecoration(color: Colors.white),
        //   child: SizedBox(
        //     width: double.infinity,
        //     height: 1,
        //   ),
        // ),
        Row(
          children: [
            _PostButton(
                icon: Icon(
                  MdiIcons.thumbUp,
                  color: likeColor,
                  size: 20.0,
                ),
                label: widget.comments.likes.length > 0
                    ? '${widget.comments.likes.length}'
                    : 'Thích',
                onTap: () async {
                  if (user != null) {
                    if (widget.comments.likes.contains(user?.uid)) {
                      setState(() {
                        likeColor = Color(0xFF1EE4B1);
                        dislikeColor = Color(0xFF627C8B);
                      });
                    } else if (widget.comments.dislikes.contains(user?.uid)) {
                      setState(() {
                        dislikeColor = Color(0xFFF95049);
                        likeColor = Color(0xFF627C8B);
                      });
                    } else {
                      setState(() {
                        likeColor = Color(0xFF627C8B);
                        dislikeColor = Color(0xFF627C8B);
                      });
                    }
                    if (widget.comments.likes.contains(user!.uid)) {
                      widget.comments.likes.remove(user!.uid);
                    } else if (widget.comments.dislikes.contains(user!.uid)) {
                      widget.comments.dislikes.remove(user!.uid);
                      widget.comments.likes.add(user!.uid);
                    } else {
                      widget.comments.likes.add(user!.uid);
                    }
                    await DBServices().updateComment(widget.comments);
                  } else {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        msg: "Vui lòng đăng nhập để thực hiện chức năng này !");
                  }
                }),
            SizedBox(
              width: getProportionateScreenWidth(50),
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.thumbDown,
                color: dislikeColor,
                size: 20.0,
              ),
              label: widget.comments.dislikes.length > 0
                  ? '${widget.comments.dislikes.length}'
                  : 'Không thích',
              onTap: () async {
                if (user != null) {
                  if (widget.comments.likes.contains(user?.uid)) {
                    setState(() {
                      likeColor = Color(0xFF1EE4B1);
                      dislikeColor = Color(0xFF627C8B);
                    });
                  } else if (widget.comments.dislikes.contains(user?.uid)) {
                    setState(() {
                      dislikeColor = Color(0xFFF95049);
                      likeColor = Color(0xFF627C8B);
                    });
                  } else {
                    setState(() {
                      likeColor = Color(0xFF627C8B);
                      dislikeColor = Color(0xFF627C8B);
                    });
                  }
                  if (widget.comments.dislikes.contains(user!.uid)) {
                    widget.comments.dislikes.remove(user!.uid);
                  } else if (widget.comments.likes.contains(user!.uid)) {
                    widget.comments.likes.remove(user!.uid);
                    widget.comments.dislikes.add(user!.uid);
                  } else {
                    widget.comments.dislikes.add(user!.uid);
                  }
                  await DBServices().updateComment(widget.comments);
                } else {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      msg: "Vui lòng đăng nhập để thực hiện chức năng này !");
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Color(0xFFEFF3F5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            // padding: const EdgeInsets.symmetric(
            //   horizontal: 12.0,
            // ),
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
