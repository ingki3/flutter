import 'package:credit_card_sms_receiver/theme/custom_app_theme.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusFilterChip extends StatefulWidget {

  final bool initStatus;
  final String label;

  StatusFilterChip({Key key, this.initStatus = false, this.label});
  @override
  _StatusFilterChipState createState() => _StatusFilterChipState();
}

class _StatusFilterChipState extends State<StatusFilterChip> {

  bool isSelected;

  @override
  void initState() {
    super.initState();
    this.isSelected = widget.initStatus;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 2.0,
        right: 2.0
      ),
      child: FilterChip(
        avatar: Icon(FontAwesomeIcons.checkCircle,
        size: 18.0,
        color: this.isSelected
              ? CustomAppTheme.nearlyWhite
              : CustomAppTheme.dark_grey,  
        ),
        label: Text(widget.label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          letterSpacing: 0.27,
          color: this.isSelected
              ? CustomAppTheme.nearlyWhite
              : CustomAppTheme.dark_grey,
        ),
        backgroundColor: this.isSelected
              ? CustomAppTheme.dark_grey
              : CustomAppTheme.nearlyWhite,
        padding: EdgeInsets.all(8.0),
        shape: StadiumBorder(
          side: BorderSide(
            color:CustomAppTheme.dark_grey
          ),
        ),
        onSelected: (bool value) {
          setState(() {
            this.isSelected = !this.isSelected;
          });
        },
      ),
    );
  }
}