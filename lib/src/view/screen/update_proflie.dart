import 'package:app_search_title/src/model/id_user.dart';
import 'package:app_search_title/src/view/desgin/shared/constants.dart';
import 'package:app_search_title/src/view/desgin/shared/loading.dart';
import 'package:app_search_title/src/viewmodel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UpdateProflie extends StatefulWidget {
  const UpdateProflie({Key? key}) : super(key: key);

  @override
  State<UpdateProflie> createState() => _UpdateProflieState();
}

class _UpdateProflieState extends State<UpdateProflie> {
  final formKey = GlobalKey<FormState>();

  //form values
  String? _currentName;
  String? _currentAge;
  String? _currentAddress;
  String? _currentPhone;
  String? _currentInterest;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<IdUser>(context);

    return StreamBuilder<IdUserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            IdUserData? userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Ppdate your proflie.',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData!.name,
                      decoration: textInputDecoration,
                      validator: (String? value) {
                        return value!.isEmpty ? 'Please enter a name' : null;
                        // return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _currentName = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // initialValue: userData.age, // remove !
                      decoration: textInputDecoration,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (String? value) {
                        if (value!.isEmpty || int.parse(value) <= 0) {
                          return 'Please enter a age';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _currentAge = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData.address, // remove !
                      decoration: textInputDecoration,
                      validator: (String? value) {
                        return value!.isEmpty ? 'Please enter a address' : null;
                        // return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _currentAddress = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData.phone, // remove !
                      decoration: textInputDecoration,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (String? value) {
                        if (value!.isEmpty || value.length != 10) {
                          return 'Please enter a phone';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _currentPhone = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // initialValue: userData.interest, // remove !
                      decoration: textInputDecoration,
                      validator: (String? value) {
                        return value!.isEmpty
                            ? 'Please enter a interest'
                            : null;
                        // return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _currentInterest = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink[400],
                        onPrimary: Colors.white,
                      ),
                      child: const Text(
                        'Update',
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            // _currentAge ?? userData.age,
                            _currentAddress ?? userData.address,
                            _currentPhone ?? userData.phone,
                            // _currentInterest ?? userData.interest,
                          );
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }
}
