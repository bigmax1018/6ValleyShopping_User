import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

class ProductRepo {
  final DioClient? dioClient;
  ProductRepo({required this.dioClient});

  Future<ApiResponse> getLatestProductList(BuildContext context, String offset, ProductType productType, String? title) async {
    late String endUrl;

     if(productType == ProductType.bestSelling){
      endUrl = AppConstants.bestSellingProductUri;
      title = getTranslated('best_selling', context);
    }
    else if(productType == ProductType.newArrival){
      endUrl = AppConstants.newArrivalProductUri;
      title = getTranslated('new_arrival',context);
    }
    else if(productType == ProductType.topProduct){
      endUrl = AppConstants.topProductUri;
      title = getTranslated('top_product', context);
    }else if(productType == ProductType.discountedProduct){
       endUrl = AppConstants.discountedProductUri;
       title = getTranslated('discounted_product', context);
     }

    try {
      final response = await dioClient!.get(
        endUrl+offset);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //Seller Products
  Future<ApiResponse> getSellerProductList(String sellerId, String offset, [String search = '', String? categoryIds, String? brandIds]) async {
    try {
      final response = await dioClient!.get(
        '${AppConstants.sellerProductUri}$sellerId/products?guest_id=1&limit=10&offset=$offset&search=$search&category=$categoryIds&brand_ids=$brandIds');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerWiseBestSellingProductList(String sellerId, String offset) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.sellerWiseBestSellingProduct}$sellerId/seller-best-selling-products?guest_id=1&limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerWiseFeaturedProductList(String sellerId, String offset) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.sellerWiseBestSellingProduct}$sellerId/seller-featured-product?guest_id=1&limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getSellerWiseRecomendedProductList(String sellerId, String offset) async {
    try {
      final response = await dioClient!.get(
          '${AppConstants.sellerWiseBestSellingProduct}$sellerId/seller-recommended-products?guest_id=1&limit=10&offset=$offset');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBrandOrCategoryProductList(bool isBrand, String id) async {
    try {
      String uri;
      if(isBrand){
        uri = '${AppConstants.brandProductUri}$id';
      }else {
        uri = '${AppConstants.categoryProductUri}$id';
      }
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getRelatedProductList(String id) async {
    try {
      final response = await dioClient!.get('${AppConstants.relatedProductUri}$id?guest_id=1');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> getFeaturedProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.featuredProductUri+offset,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  Future<ApiResponse> getLProductList(String offset) async {
    try {
      final response = await dioClient!.get(
        AppConstants.latestProductUri+offset,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getRecommendedProduct() async {
    try {
      final response = await dioClient!.get(AppConstants.dealOfTheDay);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getMostDemandedProduct() async {
    try {
      final response = await dioClient!.get(AppConstants.mostDemandedProduct);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getShopAgainFromRecentStoreList() async {
    try {
      final response = await dioClient!.get(AppConstants.shopAgainFromRecentStore);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getFindWhatYouNeed() async {
    try {
      final response = await dioClient!.get(AppConstants.findWhatYouNeed);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getJustForYouProductList() async {
    try {
      final response = await dioClient!.get(AppConstants.justForYou);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getMostSearchingProductList(int offset) async {
    try {
      final response = await dioClient!.get("${AppConstants.mostSearching}?guest_id=1&limit=10&offset=$offset");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}