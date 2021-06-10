import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:miras/controller/global_state.dart';
import 'package:miras/model/child.dart';
import 'package:miras/model/constants.dart';

// TODO: Sağ üstte id ya da countı yazdır

typedef OnDelete(); //will be defined in another page

class PersonForm extends StatefulWidget {
  final Person person;
  final state = _PersonFormState();
  final OnDelete onDelete;

  PersonForm({this.person, this.onDelete});

  @override
  _PersonFormState createState() => state;

  bool isValid() => state.validate();
}

class _PersonFormState extends State<PersonForm> {
  final form = GlobalKey<FormState>();
  var count = 0;
  int answer1 = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.people_alt),
                title: Text("Kişi Ekleme Formu"),
                centerTitle: true,
                backgroundColor: AppColors.mainColor.withOpacity(0.8),
                actions: <Widget>[
                  IconButton(
                    icon: Text("(Ç)"),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      initialValue: widget.person.childName,
                      onSaved: (val) => widget.person.childName = val,
                      validator: (val) =>
                      val.length > 1 ? null : "Lütfen isim giriniz.",
                      decoration: InputDecoration(
                          labelText: "Çocuğun İsmi: ",
                          hintText: "Çocuğun ismini giriniz"),
                    ),
                  ),
                  buildQuestion("Bu kişi hala hayatta mı?"),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildRadioButton1("Evet", 1, answer1),
                        buildRadioButton1("Hayır", 0, answer1),
                      ],
                    ),
                  ),
                  buildQuestion("Bu kişinin kaç çocuğu var?"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SpinBox(
                      min: 0,
                      max: 40,
                      value: 0,
                      onChanged: (value) => count = value.toInt(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildQuestion(String text) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black87,
                        ),
                      )),
                );
  }

  Container buildRadioButton1(String text, int val, int group) {
    return Container(
      width: 150,
      child: Row(
        children: <Widget>[
          Radio(
              value: val,
              groupValue: group,
              onChanged: (value) {
                answer1 = value;
                setState(() {});
              }),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // form validator for saving it to a list
  //empty state will be added for the debug on validation
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) {
      form.currentState.save();
    }
    return valid;
  }

}

