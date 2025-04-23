class BannerModel {
  final List<String> images;

  BannerModel({required this.images});

  factory BannerModel.fromMap(Map<String, dynamic> data) {
    var imageFromJson = data["images"];
    List<String> imageList = imageFromJson.cast<String>();
    return BannerModel(
        // image: data["image"] as List;
      // image: List.from(data["image"])
      images: imageList
    );
  }

}
