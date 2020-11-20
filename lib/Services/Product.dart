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
  final int packSize;
  final String packType;

  Product(
      {this.packType,
      this.packSize,
      this.productName,
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

Map<String, dynamic> generalProductList = {};

List<String> generalProductKeys = List<String>();

Map<String, dynamic> nonGeneralProductList = {};

List<String> nonGeneralProductKeys = List<String>();
