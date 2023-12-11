class WishlistModel {
  int? id;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ProductFullInfo? productFullInfo;

  WishlistModel(
      {this.id,
        this.customerId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.productFullInfo});

  WishlistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productFullInfo = json['product_full_info'] != null ? ProductFullInfo.fromJson(json['product_full_info']) : null;
  }


}

class ProductFullInfo {
  int? id;
  String? addedBy;
  int? userId;
  String? name;
  String? slug;
  String? productType;
  int? brandId;
  String? unit;
  int? minQty;
  int? refundable;
  String? colorImage;
  String? thumbnail;
  int? featured;
  String? videoProvider;
  String? colors;
  int? variantProduct;
  String? attributes;
  String? choiceOptions;
  String? variation;
  int? published;
  double? unitPrice;
  double? purchasePrice;
  double? tax;
  String? taxType;
  String? taxModel;
  double? discount;
  String? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? details;
  int? freeShipping;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  String? metaTitle;
  String? metaDescription;
  String? metaImage;
  int? requestStatus;

  double? shippingCost;
  int? multiplyQty;

  String? code;
  int? reviewsCount;


  ProductFullInfo(
      {this.id,
        this.addedBy,
        this.userId,
        this.name,
        this.slug,
        this.productType,
        this.brandId,
        this.unit,
        this.minQty,
        this.refundable,
        this.colorImage,
        this.thumbnail,
        this.featured,
        this.videoProvider,
        this.colors,
        this.variantProduct,
        this.attributes,
        this.choiceOptions,
        this.variation,
        this.published,
        this.unitPrice,
        this.purchasePrice,
        this.tax,
        this.taxType,
        this.taxModel,
        this.discount,
        this.discountType,
        this.currentStock,
        this.minimumOrderQty,
        this.details,
        this.freeShipping,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.featuredStatus,
        this.metaTitle,
        this.metaDescription,
        this.metaImage,
        this.requestStatus,
        this.shippingCost,
        this.multiplyQty,
        this.code,
        this.reviewsCount,
        });

  ProductFullInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    brandId = json['brand_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    colorImage = json['color_image'];
    thumbnail = json['thumbnail'];
    featured = json['featured'];
    videoProvider = json['video_provider'];
    colors = json['colors'];
    variantProduct = int.tryParse(json['variant_product'].toString());
    attributes = json['attributes'];
    choiceOptions = json['choice_options'];
    variation = json['variation'];
    published = json['published'];
    unitPrice = json['unit_price'].toDouble();
    purchasePrice = double.parse(json['purchase_price'].toString());
    tax = double.parse(json['tax'].toString());
    taxType = json['tax_type'];
    taxModel = json['tax_model'];
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
    details = json['details'];
    freeShipping = json['free_shipping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    metaImage = json['meta_image'];
    requestStatus = int.parse(json['request_status'].toString());
    shippingCost = double.parse(json['shipping_cost'].toString());
    multiplyQty = json['multiply_qty'];
    code = json['code'];
    reviewsCount = int.parse(json['reviews_count'].toString());
  }

}
