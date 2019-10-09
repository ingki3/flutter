import 'package:credit_card_sms_receiver/business_result.dart';
import 'package:credit_card_sms_receiver/map_page.dart';
import 'package:credit_card_sms_receiver/search_result.dart';
import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';


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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return MapPage(widget.result);
              }));
            },
          ),
        ],
      ),
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
              title: Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    SmoothStarRating(
                      allowHalfRating: true,
                      onRatingChanged: (v) {
                        setState(() {
                          item.rating = v;
                        });
                      },
                      starCount: 5,
                      rating: item.rating,
                      size: 40.0,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing:0.0
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                    ),
                    FlatButton(
                      child: Text("Rating!!", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      textColor: Colors.blue,
                      onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Title"),
                                content: Text("Content"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Confirm", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                    onPressed: (){},
                                  ),
                                ],
                              );
                            }
                          );
                      }
                    ),
                  ],
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


