import 'package:flutter_sixvalley_ecommerce/data/model/response/support_reply_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/support_ticket_repo.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SupportTicketProvider extends ChangeNotifier {
  final SupportTicketRepo? supportTicketRepo;
  SupportTicketProvider({required this.supportTicketRepo});

  List<SupportTicketModel>? _supportTicketList;
  List<SupportReplyModel>? _supportReplyList;
  bool _isLoading = false;

  List<SupportTicketModel>? get supportTicketList => _supportTicketList;
  List<SupportReplyModel>? get supportReplyList => _supportReplyList != null ? _supportReplyList!.reversed.toList() : _supportReplyList;
  bool get isLoading => _isLoading;



  Future<http.StreamedResponse> createSupportTicket(SupportTicketBody supportTicketBody) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await supportTicketRepo!.createNewSupportTicket(supportTicketBody ,pickedImageFileStored??[]);
    if (response.statusCode == 200) {
      showCustomSnackBar('${getTranslated('support_ticket_created_successfully', Get.context!)}', Get.context!);
      Navigator.pop(Get.context!);
      getSupportTicketList();
      _pickedImageFiles = [];
      pickedImageFileStored = [];
      _isLoading = false;
    } else {
      _isLoading = false;

    }
    _pickedImageFiles = [];
    pickedImageFileStored = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }

  Future<void> getSupportTicketList() async {
    ApiResponse apiResponse = await supportTicketRepo!.getSupportTicketList();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _supportTicketList = [];
      apiResponse.response!.data.forEach((supportTicket) => _supportTicketList!.add(SupportTicketModel.fromJson(supportTicket)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }

  Future<void> getSupportTicketReplyList(BuildContext context, int? ticketID) async {
    _supportReplyList = null;
    ApiResponse apiResponse = await supportTicketRepo!.getSupportReplyList(ticketID.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _supportReplyList = [];
      apiResponse.response!.data.forEach((supportReply) => _supportReplyList!.add(SupportReplyModel.fromJson(supportReply)));
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  Future<http.StreamedResponse> sendReply(int? ticketID, String message) async {
    _isLoading = true;
    notifyListeners();
    http.StreamedResponse response = await supportTicketRepo!.sendReply(ticketID.toString(), message, pickedImageFileStored??[]);
    if (response.statusCode == 200) {
      getSupportTicketReplyList(Get.context!, ticketID);
      _pickedImageFiles = [];
      pickedImageFileStored = [];
      _isLoading = false;
    } else {
      _isLoading = false;
      debugPrint('=========${response.statusCode.toString()}==========');
    }
    _pickedImageFiles = [];
    pickedImageFileStored = [];
    _isLoading = false;
    notifyListeners();
    return response;
  }


  Future<void> closeSupportTicket(int? ticketID) async {
    ApiResponse apiResponse = await supportTicketRepo!.closeSupportTicket(ticketID.toString());
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      getSupportTicketList();
      showCustomSnackBar('${getTranslated('ticket_closed_successfully', Get.context!)}', Get.context!, isError: false);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }



  List<String> priority = ['urgent', 'high', 'medium', 'low'];
  int selectedPriorityIndex = -1;
  String selectedPriority = getTranslated('select_priority', Get.context!)??'';
  void setSelectedPriority(int index, {bool reload = true}){
    selectedPriorityIndex = index;
    selectedPriority = getTranslated(priority[selectedPriorityIndex], Get.context!)??'High';
    notifyListeners();
  }

  List <XFile> _pickedImageFiles =[];
  List <XFile>? get pickedImageFile => _pickedImageFiles;
  List <XFile>  pickedImageFileStored = [];
  void pickMultipleImage(bool isRemove,{int? index}) async {
    if(isRemove) {
      if(index != null){
        pickedImageFileStored.removeAt(index);
      }
    }else {
      _pickedImageFiles = await ImagePicker().pickMultiImage(imageQuality: 40);
      pickedImageFileStored.addAll(_pickedImageFiles);
    }
    notifyListeners();
  }


}
