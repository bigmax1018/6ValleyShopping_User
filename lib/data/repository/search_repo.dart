
import 'dart:convert';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SearchRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getSearchProductList(String query, String? categoryIds, String? brandIds, String? sort, String? priceMin, String? priceMax, int offset) async {
    try {
      final response = await dioClient!.post(AppConstants.searchUri,
          data: {
        'search' : base64.encode(utf8.encode(query)),
            'category': categoryIds??'[]',
            'brand' : brandIds??'[]',
            'sort_by': sort,
            'price_min' : priceMin,
            'price_max' : priceMax,
            'limit' : '20',
            'offset' : offset,
            'guest_id' : '1'


      });

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSearchProductName(String name) async {
    try {
      final response = await dioClient!.get('${AppConstants.getSuggestionProductName}$name');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<void> saveSearchAddress(String searchAddress) async {
    try {
      List<String> searchKeywordList = sharedPreferences!.getStringList(AppConstants.searchAddress)??[];
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreferences!.setStringList(AppConstants.searchAddress, searchKeywordList);
    } catch (e) {
      rethrow;
    }
  }

  List<String> getSearchAddress() {
    return sharedPreferences!.getStringList(AppConstants.searchAddress) ?? [];
  }

  Future<bool> clearSearchAddress() async {
    return sharedPreferences!.setStringList(AppConstants.searchAddress, []);
  }
}
