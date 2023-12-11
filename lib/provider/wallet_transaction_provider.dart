import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/error_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/loyalty_point_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/wallet_transaction_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/payment/payment_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/model/wallet_bonus_model.dart';

class WalletTransactionProvider extends ChangeNotifier {
  final WalletTransactionRepo? transactionRepo;
  bool _isLoading = false;
  bool _firstLoading = false;
  bool _isConvert = false;
  bool get isConvert => _isConvert;
  bool get isLoading => _isLoading;
  bool get firstLoading => _firstLoading;
  int? _transactionPageSize;
  int? get transactionPageSize=> _transactionPageSize;
  TransactionModel? _walletBalance;
  TransactionModel? get walletBalance => _walletBalance;

  int? _loyaltyPointPageSize;
  int? get loyaltyPointPageSize=> _loyaltyPointPageSize;

  WalletTransactionProvider({required this.transactionRepo});

  List<WalletTransactioList> _transactionList = [];
  List<WalletTransactioList> get transactionList => _transactionList;

  List<LoyaltyPointList> _loyaltyPointList = [];
  List<LoyaltyPointList> get loyaltyPointList => _loyaltyPointList;

  Future<void> getTransactionList(BuildContext context, int offset, String type, {bool reload = true}) async {
    if(reload || offset == 1){
      _transactionList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await transactionRepo!.getWalletTransactionList(offset, type);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _walletBalance = TransactionModel.fromJson(apiResponse.response!.data);
      _transactionList.addAll(TransactionModel.fromJson(apiResponse.response!.data).walletTransactioList!);
      _transactionPageSize = TransactionModel.fromJson(apiResponse.response!.data).totalWalletTransactio;
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  Future<void> getLoyaltyPointList(BuildContext context, int offset, {bool reload = false}) async {
    if(reload){
      _loyaltyPointList = [];
    }
    _isLoading = true;
    ApiResponse apiResponse = await transactionRepo!.getLoyaltyPointList(offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _loyaltyPointList.addAll(LoyaltyPointModel.fromJson(apiResponse.response!.data).loyaltyPointList!);
      _loyaltyPointPageSize = LoyaltyPointModel.fromJson(apiResponse.response!.data).totalLoyaltyPoint;
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  Future convertPointToCurrency(BuildContext context, int point) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse = await transactionRepo!.convertPointToCurrency(point);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isConvert = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor:Colors.green,
        content: Text('${getTranslated('point_converted_successfully', Get.context!)}'),
      ));
    }else{
      _isConvert = false;
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        backgroundColor:Colors.green,
        content: Text('${getTranslated('point_converted_failed', Get.context!)}'),
      ));
    }
    notifyListeners();
  }

  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }
  Future <void> addFundToWallet(String amount, String paymentMethod) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse = await transactionRepo!.addFundToWallet(amount, paymentMethod);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isConvert = false;

      Navigator.pushReplacement(Get.context!, MaterialPageRoute(builder: (_) => PaymentScreen(url: apiResponse.response!.data['redirect_link'])));

    }else if (apiResponse.response?.statusCode == 202){
      showCustomSnackBar("Minimum= ${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['minimum_amount'].toDouble())} and Maximum=${PriceConverter.convertPrice(Get.context!, apiResponse.response?.data['maximum_amount'].toDouble())}" , Get.context!);
    }else{
      print("Bangla vai == ${apiResponse.response?.statusCode}");
      _isConvert = false;
      String? errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message;
      }

      showCustomSnackBar(errorMessage, Get.context!);
    }
    notifyListeners();
  }

  WalletBonusModel? walletBonusModel;
  Future<void> getWalletBonusBannerList() async {
    ApiResponse apiResponse = await transactionRepo!.getWalletBonusBannerList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      walletBonusModel = WalletBonusModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }


  List<String> types = ['all','order_place','loyalty_point', 'add_fund', 'add_fund_by_admin', 'order_refund'];
  List<String> filterTypes = ["All Transaction", "Order Transactions", "Converted from Loyalty Point", 'Added via Payment Method', 'Add Fund by Admin', 'Order refund'];

  String selectedFilterType = 'all_transaction';
  int selectedIndexForFilter = 0;
  void setSelectedFilterType(String type, int index, {bool reload = true}){
    selectedIndexForFilter = index;
    if(type == filterTypes[0]){
      selectedFilterType = types[0];
    }else if(type == filterTypes[1]){
      selectedFilterType = types[1];
    }else if(type == filterTypes[2]){
      selectedFilterType = types[2];
    }else if(type == filterTypes[3]){
      selectedFilterType = types[3];
    }else if(type == filterTypes[4]){
      selectedFilterType = types[4];
    }else if(type == filterTypes[5]){
      selectedFilterType = types[5];
    }
    getTransactionList(Get.context!, 1, selectedFilterType);

    if(reload){
      notifyListeners();
    }

  }



}
