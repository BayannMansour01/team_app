class ProductsResponsebody {
  final List<ProductForUpdate> products;

  ProductsResponsebody({required this.products});

  factory ProductsResponsebody.fromJson(Map<String, dynamic> json) {
    return ProductsResponsebody(
      products: List<ProductForUpdate>.from(
        json['products']
            .map((productJson) => ProductForUpdate.fromJson(productJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductForUpdate {
  final int id;
  final int amount;

  ProductForUpdate({required this.id, required this.amount});

  factory ProductForUpdate.fromJson(Map<String, dynamic> json) {
    return ProductForUpdate(
      id: json['id'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}
