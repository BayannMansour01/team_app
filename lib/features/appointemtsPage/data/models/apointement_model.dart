class AppointmentData {
  final bool status;
  final String msg;
  final Data data;

  AppointmentData({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      status: json['status'],
      msg: json['msg'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final List<Appointment> appointments;
  final List<Team> team;

  Data({
    required this.appointments,
    required this.team,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      appointments: List<Appointment>.from(
          json['appointments'].map((x) => Appointment.fromJson(x))),
      team: List<Team>.from(json['team'].map((x) => Team.fromJson(x))),
    );
  }
}

class Appointment {
  final int id;
  final String startTime;
  final String? endTime;
  final int teamId;
  final int orderId;
  final int userId;
  final int typeId;
  int statusId;
  final String createdAt;
  final String updatedAt;
  final User user;
  final Order order;

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
      endTime: json['end_time'] ?? null,
      teamId: json['team_id'],
      orderId: json['order_id'],
      userId: json['user_id'],
      typeId: json['type_id'],
      statusId: json['status_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      order: Order.fromJson(json['order']),
    );
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
}

class Order {
  final int id;
  final String? image;
  final String? desc;
  final String location;
  final String state;
  final int typeId;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<Product> products;

  Order({
    required this.id,
    this.image,
    this.desc,
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
      location: json['location'],
      state: json['state'],
      typeId: json['type_id'],
      userId: json['user_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      products:
          List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final int price;
  final int available;
  final String disc;
  final int quantity;
  final int? inverterWatt;
  final int? inverterStartWatt;
  final int? inverterVolt;
  final int? panelCapacity;
  final int? batteryType;
  final int? batteryVolt;
  final int? batteryAmper;
  final int categoryId;
  final String createdAt;
  final String updatedAt;
  final Pivot pivot;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.available,
    required this.disc,
    required this.quantity,
    this.inverterWatt,
    this.inverterStartWatt,
    this.inverterVolt,
    this.panelCapacity,
    this.batteryType,
    this.batteryVolt,
    this.batteryAmper,
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
      price: json['price'],
      available: json['available'],
      disc: json['disc'],
      quantity: json['quantity'],
      inverterWatt: json['InverterWatt'],
      inverterStartWatt: json['InverterStartWatt'],
      inverterVolt: json['inverter_volt'],
      panelCapacity: json['panel_capacity'],
      batteryType: json['battery_type'],
      batteryVolt: json['battery_volt'],
      batteryAmper: json['battery_amper'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  final int orderId;
  final int productId;
  final int amount;

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
}

class Team {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String uId;

  Team({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      uId: json['uId'],
    );
  }
}
