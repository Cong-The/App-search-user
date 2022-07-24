import 'package:app_search_title/src/model/id_user.dart';
import 'package:app_search_title/src/view/screen/authenticate/authenticate.dart';
import 'package:app_search_title/src/view/screen/home/home.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class Warapper extends StatelessWidget {
  const Warapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<IdUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
