import 'package:flutter/material.dart';
class RadioButtonsContainer extends StatefulWidget {
  @override
  _RadioButtonsContainerState createState() => _RadioButtonsContainerState();
}

class _RadioButtonsContainerState extends State<RadioButtonsContainer> {
  List<int> selectedValues = [];
  int currentColumn = 0;

  void handleRadioValueChanged(int value) {
    setState(() {
      selectedValues.add(value);
      currentColumn = (currentColumn + 1) % 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = List.generate(
      7,
          (rowIndex) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          6,
              (columnIndex) {
            int radioValue = (currentColumn * 6) + rowIndex + 7;
            return Radio<int>(
              value: radioValue,
              groupValue: null,
              onChanged: (value) {
                handleRadioValueChanged(value!);
              },
            );
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Buttons Container'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Selected Values: $selectedValues'),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rows,
            ),
          ],
        ),
      ),
    );
  }
}
