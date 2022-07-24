import 'package:app_search_title/src/model/the_user.dart';
import 'package:app_search_title/src/view/desgin/shared/constants.dart';
import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  Detail({Key? key, required this.user}) : super(key: key);
  TheUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.brown[400], title: const Text('Detail')),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        child: Center(
          child: Column(
              // mainAxisAlignment: MainAxisAlignment.s,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'User information',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Name: ${user.name}',
                  style: textStyle,
                ),
                Text(
                  'Age: ${user.age}',
                  style: textStyle,
                ),
                Text(
                  'Address: ${user.address}',
                  style: textStyle,
                ),
                Text(
                  'Phone: ${user.phone}',
                  style: textStyle,
                ),
                Text(
                  'Interest: ${user.interest}',
                  style: textStyle,
                ),
              ]),
        ),
      ),
    );
  }
}
