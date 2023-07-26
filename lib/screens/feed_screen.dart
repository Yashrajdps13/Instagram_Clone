import 'package:clone_insta/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: Image.asset("assets/img.png",
        color: primaryColor,
        height: 32
        ),
        actions:[
          IconButton(onPressed: () {}, icon: Icon(Icons.chat_bubble_outline))
        ]
      ),
    );
  }
}
