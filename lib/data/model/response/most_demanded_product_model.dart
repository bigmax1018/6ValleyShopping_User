class MostDemandedProductModel {
  int? id;
  String? banner;
  int? productId;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? slug;
  int? reviewCount;
  int? orderCount;
  int? deliveryCount;
  int? wishlistCount;

  MostDemandedProductModel(
      {this.id,
        this.banner,
        this.productId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.slug,
        this.reviewCount,
        this.orderCount,
        this.deliveryCount,
        this.wishlistCount});

  MostDemandedProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    productId = json['product_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    slug = json['slug'];
    reviewCount = json['review_count']?? 0;
    orderCount = json['order_count']?? 0;
    deliveryCount = json['delivery_count']?? 0;
    wishlistCount = json['wishlist_count']?? 0;
  }

}
