import 'package:credit_card_sms_receiver/business_result.dart';

class SearchResult{
  String business;
  double currentLatitude;
  double currentLongitude;
  List<BusinessResult> resultItem;

  SearchResult(this.business, this.currentLatitude, this.currentLongitude, this.resultItem);

  String toString() {
    return ("SearchResult : $business, $currentLatitude, $currentLongitude, ${resultItem.length}");
  }
}