class ProductForProposedSystem {
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

  ProductForProposedSystem({
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

  factory ProductForProposedSystem.fromJson(Map<String, dynamic> json) {
    return ProductForProposedSystem(
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
  int proposedSystemId;
  int productId;

  Pivot({
    required this.proposedSystemId,
    required this.productId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      proposedSystemId: json['proposed_system_id'],
      productId: json['product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'proposed_system_id': proposedSystemId,
      'product_id': productId,
    };
  }
}
