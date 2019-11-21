import 'package:credit_card_sms_receiver/business_result.dart';

class SearchResult{
  Map msgMap;
  double currentLatitude;
  double currentLongitude;

  List<BusinessResult> resultItem;

  SearchResult(this.msgMap, this.currentLatitude, this.currentLongitude, this.resultItem);

  String toString() {
    return ("SearchResult : ${this.msgMap["business"]}, $currentLatitude, $currentLongitude, ${resultItem.length}");
  }

  int indexOfBusinessResult(String id) {
    int index = 0;
    for( var item in resultItem) {
      if(item.hasSameId(id) == true){
        return index;
      }
      else{
        index = index + 1;
      }
    }
    return -1;
  }

}