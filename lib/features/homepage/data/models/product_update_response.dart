class ProductUpdateResponse {
  bool status;
  String msg;
  OrderUpdatedSuccessfully orderUpdatedSuccessfully;

  ProductUpdateResponse({
    required this.status,
    required this.msg,
    required this.orderUpdatedSuccessfully,
  });

  factory ProductUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ProductUpdateResponse(
      status: json['status'],
      msg: json['msg'],
      orderUpdatedSuccessfully:
          OrderUpdatedSuccessfully.fromJson(json['Order updated successfully']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'Order updated successfully': orderUpdatedSuccessfully.toJson(),
    };
  }
}

class OrderUpdatedSuccessfully {
  List<ProductForResponse> products;

  OrderUpdatedSuccessfully({
    required this.products,
  });

  factory OrderUpdatedSuccessfully.fromJson(Map<String, dynamic> json) {
    return OrderUpdatedSuccessfully(
      products: List<ProductForResponse>.from(
          json['products'].map((x) => ProductForResponse.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': List<dynamic>.from(products.map((x) => x.toJson())),
    };
  }
}

class ProductForResponse {
  int id;
  String name;
  String image;
  int price;
  int available;
  String disc;
  int quantity;
  int categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  Pivot pivot;

  ProductForResponse({
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

  factory ProductForResponse.fromJson(Map<String, dynamic> json) {
    return ProductForResponse(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'],
      available: json['available'],
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
      'available': available,
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
