import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/body/support_ticket_body.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';




class SupportTicketRepo {
  final DioClient? dioClient;
  SupportTicketRepo({required this.dioClient});


  Future<http.StreamedResponse> createNewSupportTicket(SupportTicketBody supportTicketModel, List<XFile?> file) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.supportTicketUri}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthProvider>(Get.context!, listen: false).getUserToken()}'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('image[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    request.fields.addAll(<String, String>{
      'type': supportTicketModel.type??'',
      'subject': supportTicketModel.subject??'',
      'description': supportTicketModel.description??'',
      'priority': supportTicketModel.priority??'',
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<ApiResponse> getSupportTicketList() async {
    try {
      final response = await dioClient!.get(AppConstants.getSupportTicketUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportReplyList(String ticketID) async {
    try {
      final response = await dioClient!.get('${AppConstants.supportTicketConversationUri}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<http.StreamedResponse> sendReply(String ticketID, String message, List<XFile?> file) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.baseUrl}${AppConstants.supportTicketReplyUri}$ticketID'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer ${Provider.of<AuthProvider>(Get.context!, listen: false).getUserToken()}'});
    for(int i=0; i<file.length;i++){
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile('image[]', file[i]!.readAsBytes().asStream(), list.length, filename: basename(file[i]!.path), contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    request.fields.addAll(<String, String>{
      'message': message??'',
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
  Future<ApiResponse> closeSupportTicket(String ticketID) async {
    try {
      final response = await dioClient!.get('${AppConstants.closeSupportTicketUri}$ticketID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}