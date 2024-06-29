class MessageModel {
  final bool status;
  final String message;
  final String token;
  MessageModel(
      {required this.status, required this.message, required this.token});

  factory MessageModel.fromJson(Map<String, dynamic> jsonData) {
    return MessageModel(
      token: jsonData['token'],
      status: jsonData['status'],
      message: jsonData['msg'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      
    
    };
}}
