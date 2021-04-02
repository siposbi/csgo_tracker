import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddMatch extends StatefulWidget {
  @override
  _AddMatchState createState() => _AddMatchState();
}

class _AddMatchState extends State<AddMatch> {
  final _formKey = GlobalKey<FormState>();

  PrimitiveWrapper roundsWon = PrimitiveWrapper(0);
  PrimitiveWrapper roundsLost = PrimitiveWrapper(0);
  PrimitiveWrapper kills = PrimitiveWrapper(0);
  PrimitiveWrapper deaths = PrimitiveWrapper(0);
  PrimitiveWrapper assists = PrimitiveWrapper(0);

  String? dropDownValue;
  List<String> mapList = [
    'Inferno',
    'Train',
    'Mirage',
    'Nuke',
    'Overpass',
    'Dust II',
    'Vertigo',
  ];

  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  Widget buildDropDown() => DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'Choose a map',
          border: OutlineInputBorder(),
        ),
        onChanged: (value) => setState(() => dropDownValue = value.toString()),
        items: mapList
            .map((cityTitle) =>
                DropdownMenuItem(value: cityTitle, child: Text("$cityTitle")))
            .toList(),
        validator: (value) => value == null ? 'Map required' : null,
      );

  Widget customFormInput(String labelText, PrimitiveWrapper variable) =>
      TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) => value!.isEmpty ? 'Number required' : null,
        onSaved: (value) => setState(() => variable.value = int.parse(value!)),
      );

  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2012),
        lastDate: DateTime.now().add(Duration(days: 1)));
    if (picked != null) {
      setState(() => {
            selectedDate = picked,
            dateController.text = DateFormat('yyyy-MM-dd').format(picked)
          });
    }
  }

  Widget buildDatePicker() => TextFormField(
        controller: dateController,
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate();
        },
        validator: (value) {
          if (value!.isEmpty || value.length < 1) {
            return 'Date required';
          }
        },
        decoration: InputDecoration(
          labelText: 'Date',
          border: OutlineInputBorder(),
        ),
      );

  Widget submitButton() => ElevatedButton(
      child: Text("Submit"),
      onPressed: () {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          _formKey.currentState!.save();

          CollectionReference users =
              FirebaseFirestore.instance.collection('test');

          users.add({
            'dateTime': selectedDate!,
            'map': dropDownValue!,
            'numberOfKills': kills.value,
            'numberOfDeaths': deaths.value,
            'numberOfAssists': assists.value,
            'roundsLost': roundsLost.value,
            'roundsWon': roundsWon.value,
          }).then((value) => Navigator.pop(context));

          // final snackbar = SnackBar(
          //   content: Text(assists.value.toString()),
          //   backgroundColor: Colors.red,
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackbar);
          // Navigator.pop(context);
        }
      });

  Widget inputRow(w1, w2, padding) => Row(
        children: [
          Expanded(child: w1),
          Padding(padding: EdgeInsets.all(padding)),
          Expanded(child: w2),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adding a new match'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildDropDown(),
            const SizedBox(
              height: 20,
            ),
            inputRow(customFormInput('Rounds won', roundsWon),
                customFormInput('Rounds lost', roundsLost), 10.0),
            const SizedBox(
              height: 20,
            ),
            inputRow(customFormInput('Kills', kills),
                customFormInput('Deaths', deaths), 10.0),
            const SizedBox(
              height: 20,
            ),
            inputRow(
                customFormInput('Assists', assists), buildDatePicker(), 10.0),
            const SizedBox(
              height: 20,
            ),
            submitButton()
          ],
        ),
      ),
    );
  }
}

class PrimitiveWrapper {
  var value;

  PrimitiveWrapper(this.value);
}
