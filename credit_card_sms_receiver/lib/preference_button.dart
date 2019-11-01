import "package:flutter/material.dart";

class PreferenceButton extends StatefulWidget {
  final String label;

  PreferenceButton(this.label);
  @override
  _PreferenceButtonState createState() => _PreferenceButtonState();
}

class _PreferenceButtonState extends State<PreferenceButton> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      child: Text(widget.label),
      
      onPressed: (){

      },
    );
  }

}