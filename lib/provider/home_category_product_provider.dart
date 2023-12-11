import 'package:flutter/foundation.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/home_category_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/home_category_product_repo.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';


class HomeCategoryProductProvider extends ChangeNotifier {
  final HomeCategoryProductRepo? homeCategoryProductRepo;
  HomeCategoryProductProvider({required this.homeCategoryProductRepo});


  final List<HomeCategoryProduct> _homeCategoryProductList = [];
  List<Product>? _productList;
  int? _productIndex;
  int? get productIndex => _productIndex;
  List<HomeCategoryProduct> get homeCategoryProductList => _homeCategoryProductList;
  List<Product>? get productList => _productList;

  Future<void> getHomeCategoryProductList(bool reload) async {
    if (_homeCategoryProductList.isEmpty || reload) {
      ApiResponse apiResponse = await homeCategoryProductRepo!.getHomeCategoryProductList();
      if (apiResponse.response != null  && apiResponse.response!.statusCode == 200) {

        if(apiResponse.response!.data.toString() == '{}'){
          if (kDebugMode) {
            print('==yup====>${apiResponse.response!.data}');
          }

        }else{
          _productList = [];
          _homeCategoryProductList.clear();
          apiResponse.response!.data.forEach((homeCategoryProduct) => _homeCategoryProductList.add(HomeCategoryProduct.fromJson(homeCategoryProduct)));
          for (var product in _homeCategoryProductList) {
            _productList!.addAll(product.products!);
          }
        }
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }
  }

}
