class Record {
  final int id;
  final int userId;
  final int orderId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Order order;
  final Appointment? appointment;
  final List<Diagnose>? diagnose;

  Record({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.order,
    this.appointment,
    this.diagnose,
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
      appointment: json['appointment'] != null
          ? Appointment.fromJson(json['appointment'])
          : null,
      diagnose: json['diagnose'] != null
          ? List<Diagnose>.from(
              json['diagnose']
                  .map((diagnoseJson) => Diagnose.fromJson(diagnoseJson)),
            )
          : null,
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
      'appointment': appointment?.toJson(),
      'diagnose': diagnose != null
          ? diagnose!.map((diagnose) => diagnose.toJson()).toList()
          : null,
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String uId;

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
  final int id;
  final String location;

  Order({
    required this.id,
    required this.location,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
    };
  }
}

class Appointment {
  final int id;
  final DateTime startTime;
  final DateTime? endTime;
  final int teamId;
  final int orderId;
  final int userId;
  final int typeId;
  final int statusId;
  final DateTime createdAt;
  final DateTime updatedAt;

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
      startTime: DateTime.parse(json['start_time']),
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
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
      'start_time': startTime.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
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

class Diagnose {
  final int id;
  final String desc;
  final int typeId;
  final DateTime date;
  final int recordId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Diagnose({
    required this.id,
    required this.desc,
    required this.typeId,
    required this.date,
    required this.recordId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Diagnose.fromJson(Map<String, dynamic> json) {
    return Diagnose(
      id: json['id'],
      desc: json['desc'],
      typeId: json['type_id'],
      date: DateTime.parse(json['date']),
      recordId: json['record_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'type_id': typeId,
      'date': date.toIso8601String(),
      'record_id': recordId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
