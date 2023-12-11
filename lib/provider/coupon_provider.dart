import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/coupon_item_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/coupon_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/coupon_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';

class CouponProvider extends ChangeNotifier {
  final CouponRepo? couponRepo;
  CouponProvider({required this.couponRepo});

  CouponModel? _coupon;
  double? _discount;
  bool _isLoading = false;
  CouponModel? get coupon => _coupon;
  double? get discount => _discount;
  bool get isLoading => _isLoading;
  String _couponCode = '';
  String get couponCode => _couponCode;

  void removeCoupon(){
    _discount = null;
    _couponCode = '';
    notifyListeners();
  }



  Future<void> applyCoupon(BuildContext context,String coupon, double order) async {
    _isLoading = true;
    _discount = 0;
    notifyListeners();
    ApiResponse apiResponse = await couponRepo!.getCoupon(coupon);
    if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      _couponCode = coupon;
      Map map = apiResponse.response!.data;
      String dis = map['coupon_discount'].toString();
      if(map['coupon_discount'] !=null){
        _discount = double.parse(dis);
      }

      showCustomSnackBar('${getTranslated('you_got', Get.context!)} '
          '${PriceConverter.convertPrice(Get.context!, _discount)} '
          '${getTranslated('discount', Get.context!)}', Get.context!, isError: false, isToaster: true);
    } else {
      showCustomSnackBar(apiResponse.response!.data, Get.context!, isToaster: true);
    }
    _isLoading = false;
    notifyListeners();
  }

  List<Coupons>? couponList;
  CouponItemModel? couponItemModel;


  Future<void> getCouponList(BuildContext context,int offset) async {
    _isLoading = true;

    ApiResponse apiResponse = await couponRepo!.getCouponList(offset);
    if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
      couponList = [];
      _isLoading = false;
      couponList!.addAll(CouponItemModel.fromJson(apiResponse.response!.data).coupons!);
      couponItemModel = CouponItemModel.fromJson(apiResponse.response!.data);

    } else {
      showCustomSnackBar(apiResponse.response!.data, Get.context!, isToaster: true);
    }
    _isLoading = false;
    notifyListeners();
  }


  List<Coupons>? availableCouponList;
  Future<void> getAvailableCouponList() async {
    availableCouponList = [];
    ApiResponse apiResponse = await couponRepo!.getAvailableCouponList();
    if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
      apiResponse.response?.data.forEach((coupon)=> availableCouponList?.add(Coupons.fromJson(coupon)));
    }
    notifyListeners();
  }


  int couponCurrentIndex = 0;
  void setCurrentIndex(int index) {
    couponCurrentIndex = index;
    notifyListeners();
  }


  Future<void> getSellerWiseCouponList(int sellerId, int offset) async {
    _isLoading = true;

    ApiResponse apiResponse = await couponRepo!.getSellerCouponList(sellerId, offset);
    if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {
      _isLoading = false;
      couponItemModel = CouponItemModel.fromJson(apiResponse.response!.data);
    } else {
      showCustomSnackBar(apiResponse.response!.data, Get.context!, isToaster: true);
    }
    _isLoading = false;
    notifyListeners();
  }


  void removePrevCouponData() {
    _coupon = null;
    _isLoading = false;
    _discount = null;
    _coupon = null;
  }
}
