import 'package:csgo_tracker/materials/custom_colors.dart';
import 'package:csgo_tracker/models/match_model.dart';
import 'package:csgo_tracker/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  InputDecoration _inputDecoration(text) => InputDecoration(
        filled: true,
        fillColor: CustomColors.CARD_COLOR,
        labelText: text,
        labelStyle: TextStyle(color: CustomColors.PRIMARY_COLOR),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.PRIMARY_COLOR)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.PRIMARY_COLOR)),
      );

  Widget buildDropDown() => DropdownButtonFormField(
        style: TextStyle(color: CustomColors.PRIMARY_COLOR),
        decoration: _inputDecoration('Choose a map'),
        dropdownColor: CustomColors.CARD_COLOR,
        onChanged: (value) => setState(() => dropDownValue = value.toString()),
        items: mapList
            .map((mapName) =>
                DropdownMenuItem(value: mapName, child: Text("$mapName")))
            .toList(),
        validator: (value) => value == null ? 'Map required' : null,
      );

  Widget customFormInput(String labelText, PrimitiveWrapper variable) =>
      TextFormField(
        style: TextStyle(color: CustomColors.PRIMARY_COLOR),
        decoration: _inputDecoration(labelText),
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
        style: TextStyle(color: CustomColors.PRIMARY_COLOR),
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
        decoration: _inputDecoration('Date'),
      );

  SnackBar _snackBar(text, color) => SnackBar(
        content: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      );

  Widget submitButton() => SizedBox(
        height: 48.0,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
              Radius.circular(16.0),
            ))),
            child: Text(
              "Add match",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();
              if (isValid) {
                _formKey.currentState!.save();

                var match = MatchModel(
                    createdAt: DateTime.now(),
                    map: dropDownValue!,
                    roundsWon: roundsWon.value,
                    roundsLost: roundsLost.value,
                    numberOfKills: kills.value,
                    numberOfAssists: assists.value,
                    numberOfDeaths: deaths.value,
                    gameDate: selectedDate);

                try {
                  ScaffoldMessenger.of(context).showSnackBar(_snackBar(
                      'Adding match to database', Colors.deepOrangeAccent));
                  await context.read<DatabaseService>().addMatch(match);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      _snackBar('Successfully added', Colors.green));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      _snackBar('An error occurred $e', Colors.red));
                }
              }
            }),
      );

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
        centerTitle: true,
        title: Text('Adding a new match'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
      ),
    );
  }
}

class PrimitiveWrapper {
  var value;

  PrimitiveWrapper(this.value);
}
