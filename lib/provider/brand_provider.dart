import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/brand_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/brand_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class BrandProvider extends ChangeNotifier {
  final BrandRepo? brandRepo;

  BrandProvider({required this.brandRepo});

  List<BrandModel> _brandList = [];

  List<BrandModel> get brandList => _brandList;

  final List<BrandModel> _originalBrandList = [];

  Future<void> getBrandList(bool reload) async {
    if (_brandList.isEmpty || reload) {
      ApiResponse apiResponse = await brandRepo!.getBrandList();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _originalBrandList.clear();
        apiResponse.response!.data.forEach((brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
        _brandList.clear();
        apiResponse.response!.data.forEach((brand) => _brandList.add(BrandModel.fromJson(brand)));
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();
    }
  }

  Future<void> getSellerWiseBrandList(int sellerId) async {

      ApiResponse apiResponse = await brandRepo!.getSellerWiseBrandList(sellerId);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _originalBrandList.clear();
        apiResponse.response!.data.forEach((brand) => _originalBrandList.add(BrandModel.fromJson(brand)));
        _brandList.clear();
        apiResponse.response!.data.forEach((brand) => _brandList.add(BrandModel.fromJson(brand)));
      } else {
        ApiChecker.checkApi( apiResponse);
      }
      notifyListeners();

  }


  void checkedToggleBrand(int index){
    _brandList[index].checked = !_brandList[index].checked!;
    notifyListeners();
  }

  bool isTopBrand = true;
  bool isAZ = false;
  bool isZA = false;

  void sortBrandLis(int value) {
    if (value == 0) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      isTopBrand = true;
      isAZ = false;
      isZA = false;
    } else if (value == 1) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      _brandList.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      isTopBrand = false;
      isAZ = true;
      isZA = false;
    } else if (value == 2) {
      _brandList.clear();
      _brandList.addAll(_originalBrandList);
      _brandList.sort((a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
      Iterable iterable = _brandList.reversed;
      _brandList = iterable.toList() as List<BrandModel>;
      isTopBrand = false;
      isAZ = false;
      isZA = true;
    }

    notifyListeners();
  }
}
