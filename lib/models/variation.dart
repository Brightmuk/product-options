class ProductVariation {
  final String description;
  final int price;
  final int quantity;
  ProductVariation({required this.description, required this.price, required this.quantity});

  // Overriding == operator
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariation &&
          runtimeType == other.runtimeType &&
          description == other.description;
          
  // Override hashCode
  @override
  int get hashCode => description.hashCode ^ description.hashCode;
}
