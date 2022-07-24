import 'package:app_search_title/src/model/the_user.dart';
import 'package:app_search_title/src/viewmodel/services/database.dart';
import 'package:app_search_title/src/view/screen/detail.dart';
import 'package:flutter/material.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  TextEditingController editingController = TextEditingController();
  List<TheUser> listuser = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    DataList().listUser.listen((event) {
      setState(() {
        listuser = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: listuser.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detail(user: listuser[index])));
                },
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(listuser[index].name),
                      Text(listuser[index].address),
                      Text(listuser[index].phone),
                      const SizedBox(
                        height: 8,
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<TheUser> dummyListData = [];
      listuser.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        listuser.clear();
        listuser.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        listuser.clear();
        _initData();
      });
    }
  }
}
