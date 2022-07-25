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
                    _textfieldName(userData!),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfieldAge(userData),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfieldAddress(userData),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfieldPhone(userData),
                    const SizedBox(
                      height: 20,
                    ),
                    _textfieldInterest(userData),
                    const SizedBox(
                      height: 20,
                    ),
                    _buttonUpdate(userData, user),
                  ],
                ),
              ),
            );
          } else {
            return const Loading();
          }
        });
  }

  Widget _textfieldName(IdUserData userData) {
    return TextFormField(
      initialValue: userData.name,
      decoration: textInputDecoration,
      validator: (String? value) {
        return value!.isEmpty ? 'Please enter a name' : null;
      },
      onChanged: (value) {
        setState(() {
          _currentName = value;
        });
      },
    );
  }

  Widget _textfieldAge(IdUserData userData) {
    return TextFormField(
      initialValue: userData.age,
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
    );
  }

  Widget _textfieldAddress(IdUserData userData) {
    return TextFormField(
      initialValue: userData.address,
      decoration: textInputDecoration,
      validator: (String? value) {
        return value!.isEmpty ? 'Please enter a address' : null;
      },
      onChanged: (value) {
        setState(() {
          _currentAddress = value;
        });
      },
    );
  }

  Widget _textfieldPhone(IdUserData userData) {
    return TextFormField(
      initialValue: userData.phone,
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
    );
  }

  Widget _textfieldInterest(IdUserData userData) {
    return TextFormField(
      initialValue: userData.interest,
      decoration: textInputDecoration,
      validator: (String? value) {
        return value!.isEmpty ? 'Please enter a interest' : null;
        // return null;
      },
      onChanged: (value) {
        setState(() {
          _currentInterest = value;
        });
      },
    );
  }

  Widget _buttonUpdate(IdUserData userData, IdUser user) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.pink[400],
        onPrimary: Colors.white,
      ),
      child: const Text(
        'Update',
      ),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          DatabaseService(uid: user.uid).updateUserData(
            _currentName ?? userData.name,
            _currentAge ?? userData.age,
            _currentAddress ?? userData.address,
            _currentPhone ?? userData.phone,
            _currentInterest ?? userData.interest,
          );
          Navigator.pop(context);
        }
      },
    );
  }
}
