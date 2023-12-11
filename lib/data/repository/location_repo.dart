import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/address_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LocationRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  LocationRepo({this.dioClient, this.sharedPreferences});




  Future<ApiResponse> getDeliveryRestrictedCountryList() async {
    try {
      final response = await dioClient!.get(AppConstants.deliveryRestrictedCountryList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedZipList() async {
    try {
      final response = await dioClient!.get(AppConstants.deliveryRestrictedZipList);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedZipBySearch(String zipcode) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryRestrictedZipList}?search=$zipcode');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDeliveryRestrictedCountryBySearch(String country) async {
    try {
      final response = await dioClient!.get('${AppConstants.deliveryRestrictedCountryList}?search=$country');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> addAddress(AddressModel addressModel) async {
    if (kDebugMode) {
      print('====Add Address==>${addressModel.toJson()}');
    }
    try {
      Response response = await dioClient!.post(
        AppConstants.addAddressUri,
        data: addressModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateAddress(AddressModel addressModel, int? addressId) async {
    try {
      Response response = await dioClient!.post(
        '${AppConstants.updateAddressUri}$addressId',
        data: addressModel.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  List<LabelAsModel> getAllAddressType({BuildContext? context}) {
    List<LabelAsModel> labelAsList= [
      LabelAsModel('home', Images.homeImage),
      LabelAsModel('office', Images.officeImage),
      LabelAsModel('others', Images.address),
    ];

    return labelAsList;
  }

  Future<ApiResponse> getAddressFromGeocode(LatLng latLng) async {
    try {
      Response response = await dioClient!.get('${AppConstants.geocodeUri}?lat=${latLng.latitude}&lng=${latLng.longitude}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> searchLocation(String text) async {
    try {
      Response response = await dioClient!.get('${AppConstants.searchLocationUri}?search_text=$text');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPlaceDetails(String? placeID) async {
    try {
      Response response = await dioClient!.get('${AppConstants.placeDetailsUri}?placeid=$placeID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getDistanceInMeter(LatLng originLatLng, LatLng destinationLatLng) async {
    try {
      Response response = await dioClient!.get('${AppConstants.distanceMatrixUri}'
          '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
          '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}


class LabelAsModel{
  String title;
  String icon;

  LabelAsModel(this.title, this.icon);
}