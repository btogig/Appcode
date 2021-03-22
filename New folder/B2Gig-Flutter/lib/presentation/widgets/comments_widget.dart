import 'package:flutter/material.dart';

TextEditingController commentsEditingController = TextEditingController();

class CommentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
          controller: commentsEditingController,
          decoration: new InputDecoration(
            labelText: "Comments",
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null),
      // ),
    );
  }
}
