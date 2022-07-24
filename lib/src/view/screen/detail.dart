import 'package:app_search_title/src/model/the_user.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  Detail({Key? key, required this.user}) : super(key: key);
  TheUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Text(user.name),
          Text(user.address),
          Text(user.phone),
        ]),
      ),
    );
  }
}
