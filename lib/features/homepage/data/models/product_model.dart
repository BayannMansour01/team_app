// class Product {
//   int id;
//   String name;
//   String image;
//   int price;
//   int available;
//   String disc;
//   int quantity;
//   int categoryId;
//   DateTime createdAt;
//   DateTime updatedAt;

//   Product({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.available,
//     required this.disc,
//     required this.quantity,
//     required this.categoryId,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       name: json['name'],
//       image: json['image'],
//       price: json['price'],
//       available: json['available'],
//       disc: json['disc'],
//       quantity: json['quantity'],
//       categoryId: json['category_id'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'price': price,
//       'available': available,
//       'disc': disc,
//       'quantity': quantity,
//       'category_id': categoryId,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }
