class AppointmentResponse {
  bool status;
  String msg;
  List<Appointment> appointments;

  AppointmentResponse({
    required this.status,
    required this.msg,
    required this.appointments,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      status: json['status'],
      msg: json['msg'],
      appointments: List<Appointment>.from(
        json['Appointments:'].map((x) => Appointment.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'Appointments:': List<dynamic>.from(appointments.map((x) => x.toJson())),
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
  User user;
  Order order;

  Appointment({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.teamId,
    required this.orderId,
    required this.userId,
    required this.typeId,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.order,
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
      user: User.fromJson(json['user']),
      order: Order.fromJson(json['order']),
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
      'user': user.toJson(),
      'order': order.toJson(),
    };
  }
}

class User {
  int id;
  String name;
  String email;
  String? emailVerifiedAt;
  String phone;
  String uid;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.phone,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      phone: json['phone'],
      uid: json['uId'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'uId': uid,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class Order {
  int id;
  String? image;
  String? desc;
  double? totalVoltage;
  int? chargeHours;
  String location;
  String state;
  int typeId;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Product> products;

  Order({
    required this.id,
    required this.image,
    required this.desc,
    required this.totalVoltage,
    required this.chargeHours,
    required this.location,
    required this.state,
    required this.typeId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      image: json['image'],
      desc: json['desc'],
      totalVoltage:
          json['totalVoltage'] != null ? json['totalVoltage'].toDouble() : null,
      chargeHours: json['chargeHours'],
      location: json['location'],
      state: json['state'],
      typeId: json['type_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      products:
          List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
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
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class Product {
  int id;
  String name;
  String image;
  double price;
  bool available;
  String disc;
  int quantity;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.disc,
    required this.quantity,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
      available: json['available'] == 1,
      disc: json['disc'],
      quantity: json['quantity'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'available': available ? 1 : 0,
      'disc': disc,
      'quantity': quantity,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  int orderId;
  int productId;
  int amount;

  Pivot({
    required this.orderId,
    required this.productId,
    required this.amount,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      orderId: json['order_id'],
      productId: json['product_id'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'amount': amount,
    };
  }
}
