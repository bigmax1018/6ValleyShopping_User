

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/selected_shipping_type.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/cart_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/chosen_shipping_method.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/response_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/shipping_method_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/shipping_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/cart_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo? cartRepo;
  CartProvider({required this.cartRepo});

  List<CartModel> _cartList = [];
  List<ChosenShippingMethodModel> _chosenShippingList = [];
  List<ChosenShippingMethodModel> get chosenShippingList =>_chosenShippingList;
  List<ShippingModel>? _shippingList;
  List<ShippingModel>? get shippingList => _shippingList;
  List<bool> isSelectedList = [];
  double amount = 0.0;
  bool isSelectAll = true;
  bool _isLoading = false;
  bool _isXyz = false;
  bool  get isXyz => _isXyz;
  CartModel? cart;
  String? _updateQuantityErrorText;
  String? get addOrderStatusErrorText => _updateQuantityErrorText;
  bool _getData = true;
  bool _addToCartLoading = false;
  bool get addToCartLoading => _addToCartLoading;

  List<CartModel> get cartList => _cartList;
  bool get isLoading => _isLoading;
  bool get getData => _getData;

  final List<int> _chosenShippingMethodIndex =[];
  List<int> get chosenShippingMethodIndex=>_chosenShippingMethodIndex;

  void setCartData(){
    _getData = true;
  }

  Future<ApiResponse> getCartDataAPI(BuildContext context, {bool reload = true}) async {
    if(reload){
      _isXyz = true;
    }

    ApiResponse apiResponse = await cartRepo!.getCartListData();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _cartList = [];
      apiResponse.response!.data.forEach((cart) => _cartList.add(CartModel.fromJson(cart)));
      _isXyz = false;
    } else {
      _isXyz = false;
       ApiChecker.checkApi(apiResponse);
    }
    _isXyz = false;
    notifyListeners();
    return apiResponse;
  }

  bool updatingIncrement = false;
  bool updatingDecrement = false;
  Future<ResponseModel> updateCartProductQuantity(int? key, int quantity, BuildContext context, bool increment, int index) async{
    if(increment){
      cartList[index].increment = true;

    }else{
      cartList[index].decrement = true;
    }
    notifyListeners();
    ResponseModel responseModel;
    ApiResponse apiResponse;
    apiResponse = await cartRepo!.updateQuantity(key, quantity);


    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      cartList[index].increment  = false;
      cartList[index].decrement = false;
      String message = apiResponse.response!.data['message'].toString();
      responseModel = ResponseModel( message,true);
      await getCartDataAPI(Get.context!, reload: false);

    } else {
      cartList[index].increment  = false;
      cartList[index].decrement = false;
      String? errorMessage = apiResponse.error.toString();
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      _updateQuantityErrorText = errorMessage;
      responseModel = ResponseModel( errorMessage,false);
    }
    notifyListeners();
    return responseModel;
  }




  Future<ApiResponse> addToCartAPI(CartModelBody cart, BuildContext context, List<ChoiceOptions> choices, List<int>? variationIndexes) async {
    _addToCartLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await cartRepo!.addToCartListData(cart, choices, variationIndexes);
    _addToCartLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.of(Get.context!).pop();
      _addToCartLoading = false;
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: false, isToaster: true);
      getCartDataAPI(Get.context!);
    } else {
      _addToCartLoading = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }


  Future<void> removeFromCartAPI(BuildContext context, int? key, int index) async{
    cartList[index].decrement = true;
    notifyListeners();
    ApiResponse apiResponse = await cartRepo!.removeFromCart(key);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      cartList[index].decrement = false;
      getCartDataAPI(Get.context!, reload: false);
    } else {
      cartList[index].decrement = false;
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();

  }


  void getShippingMethod(BuildContext context, List<List<CartModel>> cartProdList) async {
    _isLoading = true;
    _getData = false;
    List<int?> sellerIdList = [];
    List<String?> sellerTypeList = [];
    List<String?> groupList = [];
    _shippingList = [];
    for(List<CartModel> element in cartProdList){
      sellerIdList.add(element[0].sellerId);
      sellerTypeList.add(element[0].sellerIs);
      groupList.add(element[0].cartGroupId);
      _shippingList!.add(ShippingModel(-1, element[0].cartGroupId, []));
    }

    await getChosenShippingMethod(context);
    for(int i=0; i<sellerIdList.length; i++) {
      ApiResponse apiResponse = await cartRepo!.getShippingMethod(sellerIdList[i],sellerTypeList[i] );

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        List<ShippingMethodModel> shippingMethodList =[];
        apiResponse.response!.data.forEach((shipping) => shippingMethodList.add(ShippingMethodModel.fromJson(shipping)));

        _shippingList![i].shippingMethodList =[];
        _shippingList![i].shippingMethodList!.addAll(shippingMethodList);
        int index = -1;
        int? shipId = -1;
        for(ChosenShippingMethodModel cs in _chosenShippingList) {
          if(cs.cartGroupId == groupList[i]) {
            shipId = cs.shippingMethodId;
            break;
          }
        }
        if(shipId != -1) {
          for(int j=0; j<_shippingList![i].shippingMethodList!.length; j++) {
            if(_shippingList![i].shippingMethodList![j].id == shipId) {
              index = j;
              break;
            }
          }
        }
        _shippingList![i].shippingIndex = index;
      } else {
        if(context.mounted){
        }
        ApiChecker.checkApi( apiResponse);
      }
      _isLoading = false;
      notifyListeners();
    }

  }

  void getAdminShippingMethodList(BuildContext context) async {
    _isLoading = true;
    _getData = false;
    _shippingList = [];
    await getChosenShippingMethod(context);
    ApiResponse apiResponse = await cartRepo!.getShippingMethod(1,'admin');
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _shippingList!.add(ShippingModel(-1, '', []));
      List<ShippingMethodModel> shippingMethodList =[];
      apiResponse.response!.data.forEach((shipping) => shippingMethodList.add(ShippingMethodModel.fromJson(shipping)));

      _shippingList![0].shippingMethodList =[];
      _shippingList![0].shippingMethodList!.addAll(shippingMethodList);
      int index = -1;


      if(_chosenShippingList.isNotEmpty){
        for(int j=0; j<_shippingList![0].shippingMethodList!.length; j++) {
          if(_shippingList![0].shippingMethodList![j].id == _chosenShippingList[0].shippingMethodId) {
            index = j;
            break;
          }
        }
      }

      _shippingList![0].shippingIndex = index;
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    _isLoading = false;
    notifyListeners();

  }


  Future<void> getChosenShippingMethod(BuildContext context) async {
    ApiResponse apiResponse = await cartRepo!.getChosenShippingMethod();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _chosenShippingList = [];
      apiResponse.response!.data.forEach((shipping) => _chosenShippingList.add(ChosenShippingMethodModel.fromJson(shipping)));
      notifyListeners();
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }




  void setSelectedShippingMethod(int? index , int sellerIndex) {
    _shippingList![sellerIndex].shippingIndex = index;
    notifyListeners();
  }


  void initShippingMethodIndexList(int length) {
    _shippingList =[];
    for(int i =0; i< length; i++){
      _shippingList!.add(ShippingModel(0,'', null));
    }

  }





  Future addShippingMethod(BuildContext context, int? id, String? cartGroupId) async {
    ApiResponse apiResponse = await cartRepo!.addShippingMethod(id,cartGroupId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Navigator.pop(Get.context!);
      getChosenShippingMethod(Get.context!);
      showCustomSnackBar(getTranslated('shipping_method_added_successfully', Get.context!), Get.context!, isError: false);
    getCartDataAPI(Get.context!);
    } else {
      Navigator.pop(Get.context!);
      ApiChecker.checkApi(apiResponse);
    }
    notifyListeners();
  }



  String? _selectedShippingType;
  String? get selectedShippingType=>_selectedShippingType;

  final List<SelectedShippingType> _selectedShippingTypeList = [];
  List<SelectedShippingType> get selectedShippingTypeList => _selectedShippingTypeList;

  Future<void> getSelectedShippingType(BuildContext context, int sellerId, String sellerType) async {
    ApiResponse apiResponse = await cartRepo!.getSelectedShippingType(sellerId, sellerType);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
     _selectedShippingType = apiResponse.response!.data['shipping_type'];
     _selectedShippingTypeList.add(SelectedShippingType(sellerId: sellerId, selectedShippingType: _selectedShippingType));
    } else {
      if(context.mounted){

      }
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

}
