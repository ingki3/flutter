import 'package:credit_card_sms_receiver/business_result.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:flutter/material.dart';


class BusinessSelectPage extends StatefulWidget {
  final SearchResult result;

  BusinessSelectPage(this.result);

  @override
  _BusinessSelectPageState createState() => _BusinessSelectPageState();
}

class _BusinessSelectPageState extends State<BusinessSelectPage> {

List<BusinessResult> _data;

  @override
  void initState() {
    super.initState();
    this._data = widget.result.resultItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: _buildPanel(),
     )
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((BusinessResult item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.name),
            );
          },
          body: Container(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(item.address),
                  subtitle: Text('To delete this panel, tap the trash can icon'),
                  trailing: Icon(Icons.map),
                  onTap: () {
                  }
                ),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}


