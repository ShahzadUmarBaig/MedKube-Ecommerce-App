class Product {
  final String productName;
  final double price;
  final bool otc;
  final String category;
  final String formula;
  final String description;
  final bool inStock;
  final String company;
  final String type;
  final String imagePath;

  Product(
      {this.productName,
      this.otc,
      this.category,
      this.formula,
      this.description,
      this.inStock,
      this.company,
      this.type,
      this.imagePath,
      this.price});
}
