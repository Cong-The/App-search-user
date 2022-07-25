import 'package:app_search_title/src/model/id_user.dart';
import 'package:app_search_title/src/view/desgin/shared/loading.dart';
import 'package:app_search_title/src/viewmodel/services/database.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawinngHeader extends StatefulWidget {
  const DrawinngHeader({Key? key}) : super(key: key);

  @override
  State<DrawinngHeader> createState() => _DrawinngHeaderState();
}

class _DrawinngHeaderState extends State<DrawinngHeader> {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<IdUser>(context);
    return StreamBuilder<IdUserData>(
        stream: DatabaseService(uid: customer.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            IdUserData? customerData = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Image.asset(
                    'assets/images/person.png',
                  ),
                ),
                Text(customerData!.name)
              ],
            );
          } else {
            return const Loading();
          }
        });
  }
}
