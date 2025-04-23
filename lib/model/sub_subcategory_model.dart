class SubSubCategoryModel {
  final String name;
  final String subcategoryId;
  final String subsubcategoryId;

  SubSubCategoryModel({required this.name, required this.subcategoryId, required this.subsubcategoryId});

  factory SubSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubSubCategoryModel(
      name: json["name"],
      subcategoryId: json["subcategoryId"],
      subsubcategoryId: json["subsubcategoryId"]
    );
  }
}