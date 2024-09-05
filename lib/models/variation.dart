class ProductVariation {
  final String description;
  final int price;
  final int quantity;
  final bool selected;
  ProductVariation({required this.description, this.price=0, this.quantity=0, this.selected=false});

  // Method to toggle the 'selected' state
  ProductVariation toggleSelection() {
    return ProductVariation(
      description: this.description,
      price: this.price,
      quantity: this.quantity,
      selected: !this.selected, 
    );
  }

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
