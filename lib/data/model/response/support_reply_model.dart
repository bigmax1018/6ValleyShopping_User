class SupportReplyModel {
  int? id;
  String? customerMessage;
  String? adminMessage;
  String? createdAt;
  String? updatedAt;
  List<String>? attachment;
  String? adminId;

  SupportReplyModel(
      {this.id,
        this.customerMessage,
        this.adminMessage,
        this.createdAt,
        this.updatedAt,
        this.attachment,
        this.adminId,
      });

  SupportReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerMessage = json['customer_message'];
    adminMessage = json['admin_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    adminId = json['admin_id'].toString();
    if(json['attachment'] != null){
      attachment = json['attachment'].cast<String>();
    }else{
      attachment = [];
    }
  }


}
