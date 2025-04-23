

class ProductModel {
  final String productId;
  final String productName;
  final List<String> size;
  final String description;
  final String brand;
  final String productImage;
  final double price;
  final double sellingPrice;
  final String categoryId;
  final String subcategoryId;
  final String subsubcategoryId;
  final String gender;
  final int quantity;


  ProductModel(
      {required this.productId,
      required this.productName,
      required this.size,
      required this.description,
      required this.brand,
      required this.productImage,
      required this.price,
        required this.sellingPrice,
      required this.categoryId,
      required this.subcategoryId,
      required this.subsubcategoryId,
      required this.gender,
        required this.quantity
      });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final sizeFromJson = json["size"];
    List<String> sizeList = sizeFromJson.cast<String>();
    return ProductModel(
        productId: json["productId"],
        productName: json["productName"],
        size: sizeList,
        description: json["description"],
        brand: json["brand"],
        productImage: json["productImage"],
        price: json["price"] ?? 0.0,
        sellingPrice: json["sellingPrice"] ?? 0.0,
        categoryId: json["categoryId"],
        subcategoryId: json["subcategoryId"],
        subsubcategoryId: json["subsubcategoryId"],
        gender: json["gender"],
      quantity: json["quantity"] ?? 0
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId" : productId,
      "productName" : productName,
      "size" : size,
      "description" : description,
      "brand" : brand,
      "productImage" : productImage,
      "price" : price,
      "sellingPrice" : sellingPrice,
      "categoryId" : categoryId,
      "subcategoryId" : subcategoryId,
      "subsubcategoryId" : subsubcategoryId,
      "gender" : gender,
      "quantity" : quantity
    };
  }
}
