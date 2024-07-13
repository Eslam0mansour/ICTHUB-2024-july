class ProductDataModel {
  String? name;
  String? description;
  double? price;
  String? imageUrl;

  ProductDataModel({
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory ProductDataModel.fromMapJson(Map<String, dynamic> map) {
    return ProductDataModel(
      name: map['title'],
      imageUrl: map['thumbnail'],
      price: map['price'],
      description: map['description'],
    );
  }
}
