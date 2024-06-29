class RecordsResponse {
  bool status;
  String msg;
  List<Record> records;

  RecordsResponse({
    required this.status,
    required this.msg,
    required this.records,
  });

  factory RecordsResponse.fromJson(Map<String, dynamic> json) {
    return RecordsResponse(
      status: json['status'],
      msg: json['msg'],
      records: List<Record>.from(
        json['records'].map((x) => Record.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'records': List<dynamic>.from(records.map((x) => x.toJson())),
    };
  }
}

class Record {
  int id;
  int userId;
  int orderId;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  Order order;
  Appointment appointment;

  Record({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.order,
    required this.appointment,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      userId: json['user_id'],
      orderId: json['order_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
      order: Order.fromJson(json['order']),
      appointment: Appointment.fromJson(json['appointment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
      'order': order.toJson(),
      'appointment': appointment.toJson(),
    };
  }
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String uId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uId: json['uId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
    };
  }
}

class Order {
  int id;
  String? image;
  String? desc;
  dynamic totalVoltage;
  dynamic chargeHours;
  String location;
  String state;
  int typeId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;

  Order({
    required this.id,
    this.image,
    this.desc,
    this.totalVoltage,
    this.chargeHours,
    required this.location,
    required this.state,
    required this.typeId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      image: json['image'],
      desc: json['desc'],
      totalVoltage: json['totalVoltage'],
      chargeHours: json['chargeHours'],
      location: json['location'],
      state: json['state'],
      typeId: json['type_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'desc': desc,
      'totalVoltage': totalVoltage,
      'chargeHours': chargeHours,
      'location': location,
      'state': state,
      'type_id': typeId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Appointment {
  int id;
  String startTime;
  String? endTime;
  int teamId;
  int orderId;
  int userId;
  int typeId;
  int statusId;
  DateTime createdAt;
  DateTime updatedAt;

  Appointment({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.teamId,
    required this.orderId,
    required this.userId,
    required this.typeId,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      teamId: json['team_id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      typeId: json['type_id'],
      statusId: json['status_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_time': startTime,
      'end_time': endTime,
      'team_id': teamId,
      'order_id': orderId,
      'user_id': userId,
      'type_id': typeId,
      'status_id': statusId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
