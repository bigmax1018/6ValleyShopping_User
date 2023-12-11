class OfflinePaymentModel {
  List<OfflineMethods>? offlineMethods;

  OfflinePaymentModel({this.offlineMethods});

  OfflinePaymentModel.fromJson(Map<String, dynamic> json) {
    if (json['offline_methods'] != null) {
      offlineMethods = <OfflineMethods>[];
      json['offline_methods'].forEach((v) {
        offlineMethods!.add(OfflineMethods.fromJson(v));
      });
    }
  }

}

class OfflineMethods {
  int? id;
  String? methodName;
  List<MethodFields>? methodFields;
  List<MethodInformations>? methodInformations;
  int? status;
  String? createdAt;
  String? updatedAt;

  OfflineMethods(
      {this.id,
        this.methodName,
        this.methodFields,
        this.methodInformations,
        this.status,
        this.createdAt,
        this.updatedAt});

  OfflineMethods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodName = json['method_name'];
    if (json['method_fields'] != null) {
      methodFields = <MethodFields>[];
      json['method_fields'].forEach((v) {
        methodFields!.add(MethodFields.fromJson(v));
      });
    }
    if (json['method_informations'] != null) {
      methodInformations = <MethodInformations>[];
      json['method_informations'].forEach((v) {
        methodInformations!.add(MethodInformations.fromJson(v));
      });
    }
    status = int.parse(json['status'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class MethodFields {
  String? inputName;
  String? inputData;

  MethodFields({this.inputName, this.inputData});

  MethodFields.fromJson(Map<String, dynamic> json) {
    inputName = json['input_name'];
    inputData = json['input_data'];
  }


}

class MethodInformations {
  String? customerInput;
  String? customerPlaceholder;
  int? isRequired;

  MethodInformations(
      {this.customerInput, this.customerPlaceholder, this.isRequired});

  MethodInformations.fromJson(Map<String, dynamic> json) {
    customerInput = json['customer_input'];
    customerPlaceholder = json['customer_placeholder'];
    isRequired = json['is_required'];
  }

}
