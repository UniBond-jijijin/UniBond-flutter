import 'package:flutter/material.dart';

class PostDetailsScreen extends StatefulWidget {
  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  List<Comment> comments = [];

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('질문'),
      ),
      body: ListView(
        children: [
          // 게시물 부분
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '진지지',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7.0),
                Text(
                  '망막색소변성증',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '게시물 내용',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
          // 댓글 부분
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '댓글',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                for (var comment in comments)
                  CommentWidget(
                    author: comment.author,
                    comment: comment.comment,
                  ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: '댓글을 작성하세요',
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                InkWell(
                  onTap: () {
                    if (commentController.text.isNotEmpty) {
                      addComment();
                    }
                  },
                  child: Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addComment() {
    setState(() {
      comments.add(
        Comment(
          author: '지지진',
          comment: commentController.text,
        ),
      );
      commentController.clear();
    });
  }
}

class Comment {
  final String author;
  final String comment;

  Comment({required this.author, required this.comment});
}

class CommentWidget extends StatelessWidget {
  final String author;
  final String comment;

  CommentWidget({required this.author, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$author 님의 댓글',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(comment),
        ],
      ),
    );
  }
}
