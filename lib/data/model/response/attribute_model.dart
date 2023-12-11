class AttributeModel {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;


  AttributeModel(
      {this.id, this.name, this.createdAt, this.updatedAt});

  AttributeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
