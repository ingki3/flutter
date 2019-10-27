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
}