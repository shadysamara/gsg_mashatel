class Product {
  String name;
  String price;
  String description;
  bool isCall;
  bool isMessage;
  String marketId;
  String imageUrl;
  String productId;
  Product(this.description, this.imageUrl, this.isCall, this.isMessage,
      this.marketId, this.name, this.price);
  Product.fromMap(Map map) {
    this.name = map['productName'];
    this.price = map['productPrice'];
    this.description = map['productDescription'];
    this.isCall = map['allowCalling'];
    this.isMessage = map['allowMessaging'];
    this.imageUrl = map['imageUrl'];
    this.marketId = map['marketId'];
    this.productId = map['productId'];
  }
}
