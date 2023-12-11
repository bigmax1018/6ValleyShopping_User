import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/seller_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/model/more_store_model.dart';

class SellerProvider extends ChangeNotifier {
  final SellerRepo? sellerRepo;
  SellerProvider({required this.sellerRepo});

  List<SellerModel> _orderSellerList = [];
  SellerModel? _sellerModel;

  List<SellerModel> get orderSellerList => _orderSellerList;
  SellerModel? get sellerModel => _sellerModel;

  void initSeller(String sellerId, BuildContext context) async {
    _orderSellerList =[];
    ApiResponse apiResponse = await sellerRepo!.getSeller(sellerId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _orderSellerList =[];
      _orderSellerList.add(SellerModel.fromJson(apiResponse.response!.data));
      _sellerModel = SellerModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  int shopMenuIndex = 0;
  void setMenuItemIndex(int index, {bool notify = true}){
    debugPrint('===================index is ===> ${index.toString()}');
    shopMenuIndex = index;
    if(notify){
      notifyListeners();
    }

  }

  bool isLoading = false;

  List<MoreStoreModel> moreStoreList =[];
  Future<ApiResponse> getMoreStore() async {
    moreStoreList = [];
    isLoading = true;
    ApiResponse apiResponse = await sellerRepo!.getMoreStore();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((store)=> moreStoreList.add(MoreStoreModel.fromJson(store)));
    } else {
      isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

}
