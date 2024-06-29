class BasicResponse {
  bool status;
  String msg;

  BasicResponse({
    required this.status,
    required this.msg,
  });

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      status: json['status'],
      msg: json['msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
    };
  }
}
