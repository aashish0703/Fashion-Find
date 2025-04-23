class SubcategoryModel {
  final String name;
  final String categoryId;
  final String subcategoryId;

  SubcategoryModel({required this.name, required this.categoryId, required this.subcategoryId});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      name: json["name"],
      categoryId: json["categoryId"],
      subcategoryId: json["subcategoryId"]
    );
  }
}