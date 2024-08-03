class ProductResponse {
  bool status;
  String msg;
  List<Productforshow> products;

  ProductResponse({
    required this.status,
    required this.msg,
    required this.products,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'],
      msg: json['msg'],
      products: List<Productforshow>.from(
          json['products'].map((x) => Productforshow.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class Productforshow {
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
  final String? batteryType;
  final int? batteryVolt;
  final int? batteryAmper;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Productforshow({
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
  });

  factory Productforshow.fromJson(Map<String, dynamic> json) {
    return Productforshow(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'available': available,
      'disc': disc,
      'quantity': quantity,
      'InverterWatt': inverterWatt,
      'InverterStartWatt': inverterStartWatt,
      'inverter_volt': inverterVolt,
      'panel_capacity': panelCapacity,
      'battery_type': batteryType,
      'battery_volt': batteryVolt,
      'battery_amper': batteryAmper,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
