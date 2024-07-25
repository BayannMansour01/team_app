class ProductUpdate {
  final int id;
  final int amount;

  ProductUpdate({required this.id, required this.amount});

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
    };
  }
}
