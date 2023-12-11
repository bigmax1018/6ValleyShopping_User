import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/product_details_repo.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/wishlist_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wishlist/model/wishlist_model.dart';

class WishListProvider extends ChangeNotifier {
  final WishListRepo? wishListRepo;
  final ProductDetailsRepo? productDetailsRepo;
  WishListProvider({required this.wishListRepo, required this.productDetailsRepo});

  final bool _isLoading = false;
  bool get isLoading => _isLoading;



  List<WishlistModel>? _wishList;
  List<WishlistModel>? get wishList => _wishList;


  List<int> addedIntoWish =[];


  void addWishList(int? productID) async {
    addedIntoWish.add(productID!);
    ApiResponse apiResponse = await wishListRepo!.addWishList(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      String? message = map['message'];
      showCustomSnackBar(message, Get.context!, isError: false);

    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  void removeWishList(int? productID, {int? index}) async {
    addedIntoWish.removeAt(addedIntoWish.indexOf(productID!));
    ApiResponse apiResponse = await wishListRepo!.removeWishList(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getWishList();
      Map map = apiResponse.response!.data;
      String? message = map['message'];
      showCustomSnackBar(message, Get.context!, isError: false);
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  Future<void> getWishList() async {
    ApiResponse apiResponse = await wishListRepo!.getWishList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _wishList = [];
      apiResponse.response?.data.forEach((wish)=> _wishList?.add(WishlistModel.fromJson(wish)));
      if(_wishList!.isNotEmpty){
        for(int i=0; i< _wishList!.length; i++){
          addedIntoWish.add(_wishList![i].productId!);
        }

      }
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

}
