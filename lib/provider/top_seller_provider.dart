import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/top_seller_repo.dart';

class TopSellerProvider extends ChangeNotifier {
  final TopSellerRepo? topSellerRepo;

  TopSellerProvider({required this.topSellerRepo});

   List<TopSellerModel>? topSellerList;
  int? _topSellerSelectedIndex;

  int? get topSellerSelectedIndex => _topSellerSelectedIndex;

  Future<void> getTopSellerList(bool reload) async {

    if (reload || topSellerList == null) {
      topSellerList = [];
      ApiResponse apiResponse = await topSellerRepo!.getTopSeller();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200 && apiResponse.response!.data.toString() != '{}') {
        apiResponse.response!.data.forEach((category) => topSellerList!.add(TopSellerModel.fromJson(category)));
        _topSellerSelectedIndex = 0;
      }
      notifyListeners();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _topSellerSelectedIndex = selectedIndex;
    notifyListeners();
  }
}
