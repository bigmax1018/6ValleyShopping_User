class ErrorResponse {
  List<Errors>? errors;

  ErrorResponse({this.errors});

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

}

class Errors {
  String? code;
  String? message;

  Errors({this.code, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

}
