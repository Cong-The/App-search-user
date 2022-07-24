import 'package:app_search_title/src/viewmodel/services/auth.dart';
import 'package:app_search_title/src/view/screen/drawing_deader.dart';
import 'package:app_search_title/src/view/screen/update_proflie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'body_home.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.brown[200]),
              child: const DrawinngHeader(),
            ),
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text('Proflie'),
              onTap: () {
                // Navigator.pop(context);
                _showUpdateProflie(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onTap: () async {
                // Navigator.pop(context);
                await _authService.signOut();
                await FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      body: const BodyHome(),
    );
  }

  void _showUpdateProflie(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: const UpdateProflie(),
          );
        });
  }
}
