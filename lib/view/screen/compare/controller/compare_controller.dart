import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/attribute_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/model/compare_model.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/repository/compare_repo.dart';

class CompareProvider extends ChangeNotifier {
  final CompareRepo? compareRepo;
  CompareProvider({this.compareRepo});



  void addCompareList(int productID) async {
    ApiResponse apiResponse = await compareRepo!.addCompareProductList(productID);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getCompareList();
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: false);
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  List<int> compIds = [];
  CompareModel? compareModel;
  void getCompareList() async {

    ApiResponse apiResponse = await compareRepo!.getCompareProductList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      compIds = [];
      compareModel = null;
      compareModel = CompareModel.fromJson(apiResponse.response?.data);
      for(int i = 0; i< compareModel!.compareLists!.length; i++){
        compIds.add(compareModel!.compareLists![i].productId!);
      }
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  void removeAllCompareList() async {
    ApiResponse apiResponse = await compareRepo!.removeAllCompareProductList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: false);
      getCompareList();
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }

  void replaceCompareList(int compareId, int productId) async {
    ApiResponse apiResponse = await compareRepo!.replaceCompareProductList(compareId, productId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getCompareList();
      showCustomSnackBar(apiResponse.response!.data['message'], Get.context!, isError: false);
    } else {
      showCustomSnackBar(apiResponse.error.toString(), Get.context!);
    }
    notifyListeners();
  }


  List<AttributeModel>? attributeList = [];
  void getAttributeList() async {
    ApiResponse response = await compareRepo!.getAttributeList();
    if (response.response != null && response.response!.statusCode == 200) {
      attributeList = [];
      response.response!.data.forEach((attribute) {
        attributeList!.add(AttributeModel.fromJson(attribute));
      });
    } else {
      ApiChecker.checkApi( response);
    }
    notifyListeners();

  }





}
