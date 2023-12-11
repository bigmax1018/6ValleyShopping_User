import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/flash_deal_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/flash_deal_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:intl/intl.dart';

class FlashDealProvider extends ChangeNotifier {
  final FlashDealRepo? megaDealRepo;
  FlashDealProvider({required this.megaDealRepo});

  FlashDealModel? _flashDeal;
  final List<Product> _flashDealList = [];
  Duration? _duration;
  Timer? _timer;
  FlashDealModel? get flashDeal => _flashDeal;
  List<Product> get flashDealList => _flashDealList;
  Duration? get duration => _duration;
  int? _currentIndex;
  int? get currentIndex => _currentIndex;

  Future<void> getMegaDealList(bool reload, bool notify) async {
    if (_flashDealList.isEmpty || reload) {
      ApiResponse apiResponse = await megaDealRepo!.getFlashDeal();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        _flashDeal = FlashDealModel.fromJson(apiResponse.response!.data);

        if(_flashDeal!.id != null) {
          DateTime endTime = DateFormat("yyyy-MM-dd").parse(_flashDeal!.endDate!).add(const Duration(days: 1));
          _duration = endTime.difference(DateTime.now());
          _timer?.cancel();
          _timer = null;
          _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
            _duration = _duration! - const Duration(seconds: 1);
            notifyListeners();

          });

          ApiResponse megaDealResponse = await megaDealRepo!.getFlashDealList(_flashDeal!.id.toString());
          if (megaDealResponse.response != null && megaDealResponse.response!.statusCode == 200) {
            _flashDealList.clear();
            megaDealResponse.response!.data.forEach((flashDeal) => _flashDealList.add(Product.fromJson(flashDeal)));
            _currentIndex = 0;
            notifyListeners();
          } else {
            ApiChecker.checkApi( megaDealResponse);
          }
        } else {
          notifyListeners();
        }
      } else {
        ApiChecker.checkApi( apiResponse);
      }
    }
  }
  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
