class Category {
  final String name;
  final String categoryId;
  final String image;

  Category({required this.name, required this.categoryId, required this.image});

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
        name: data["name"],
        categoryId: data["categoryId"],
        image: data["image"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name" : name,
      "categoryId" : categoryId,
      "image" : image
    };
  }
}