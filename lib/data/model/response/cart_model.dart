import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
class CartModel {
  int? id;
  int? productId;
  String? image;
  String? name;
  String? thumbnail;
  int? sellerId;
  String? sellerIs;
  String? seller;
  double? price;
  double? discountedPrice;
  int? quantity;
  int? maxQuantity;
  String? variant;
  String? color;
  Variation? variation;
  double? discount;
  String? discountType;
  double? tax;
  String? taxModel;
  String? taxType;
  int? shippingMethodId;
  String? cartGroupId;
  String? shopInfo;
  List<ChoiceOptions>? choiceOptions;
  List<int>? variationIndexes;
  double?  shippingCost;
  String? shippingType;
  int? minimumOrderQuantity;
  ProductInfo? productInfo;
  String? productType;
  String? slug;
  double? minimumOrderAmountInfo;
  FreeDeliveryOrderAmount? freeDeliveryOrderAmount;
  bool? increment;
  bool? decrement;




  CartModel(
      this.id,
      this.productId,
      this.thumbnail,
      this.name,
      this.seller,
      this.price,
      this.discountedPrice,
      this.quantity,
      this.maxQuantity,
      this.variant,
      this.color,
      this.variation,
      this.discount,
      this.discountType,
      this.tax,
      this.taxModel,
      this.taxType,
      this.shippingMethodId,
      this.cartGroupId,
      this.sellerId,
      this.sellerIs,
      this.image,
      this.shopInfo,
      this.choiceOptions,
      this.variationIndexes,
      this.shippingCost,
      this.minimumOrderQuantity,
      this.productType,
      this.slug,
      this.minimumOrderAmountInfo,
      this.freeDeliveryOrderAmount,
      this.increment,
      this.decrement,
      );


  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = int.parse(json['product_id'].toString());
    name = json['name'];
    seller = json['seller'];
    thumbnail = json['thumbnail'];
    sellerId = int.parse(json['seller_id'].toString());
    sellerIs = json['seller_is'];
    image = json['image'];
    price = json['price'].toDouble();
    discountedPrice = json['discounted_price'];
    quantity = int.parse(json['quantity'].toString());
    maxQuantity = json['max_quantity'];
    variant = json['variant'];
    color = json['color'];
    variation = json['variation'] != null ? Variation.fromJson(json['variation']) : null;
    discount = json['discount'].toDouble();
    discountType = json['discount_type'];
    tax = json['tax'].toDouble();
    taxModel = json['tax_model'];
    taxType = json['tax_type'];
    shippingMethodId = json['shipping_method_id'];
    cartGroupId = json['cart_group_id'];
    shopInfo = json['shop_info'];
    if (json['choice_options'] != null) {
      choiceOptions = [];
      json['choice_options'].forEach((v) {choiceOptions!.add(ChoiceOptions.fromJson(v));
      });
    }
    variationIndexes = json['variation_indexes'] != null ? json['variation_indexes'].cast<int>() : [];
    if(json['shipping_cost'] != null){
      shippingCost =double.parse(json['shipping_cost'].toString());
    }
    if(json['shipping_type'] != null){
      shippingType = json['shipping_type'];
    }
    productInfo = json['product'] != null ? ProductInfo.fromJson(json['product']) : null;
    productType = json['product_type'];
    slug = json['slug'];
    if(json['minimum_order_amount_info'] != null){
      try{
        minimumOrderAmountInfo = json['minimum_order_amount_info'].toDouble();
      }catch(e){
        minimumOrderAmountInfo = double.parse(json['minimum_order_amount_info'].toString());
      }
    }
    increment = false;
    decrement = false;
    freeDeliveryOrderAmount = json['free_delivery_order_amount'] != null ? FreeDeliveryOrderAmount.fromJson(json['free_delivery_order_amount']) : null;

  }


}

class ProductInfo {
  int? minimumOrderQty;
  int? totalCurrentStock;

  ProductInfo({ this.minimumOrderQty, this.totalCurrentStock});

  ProductInfo.fromJson(Map<String, dynamic> json) {
    if(json['minimum_order_qty'] != null) {
      try{
        minimumOrderQty = json['minimum_order_qty'];
      }catch(e){
        minimumOrderQty = int.parse(json['minimum_order_qty'].toString());
      }
    }
    totalCurrentStock = json['total_current_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['minimum_order_qty'] = minimumOrderQty;
    data['total_current_stock'] = totalCurrentStock;
    return data;
  }
}

class FreeDeliveryOrderAmount {
  int? status;
  double? amount;
  int? percentage;
  double? shippingCostSaved;
  double? amountNeed;


  FreeDeliveryOrderAmount(
      {this.status,
        this.amount,
        this.percentage,
        this.shippingCostSaved,
        this.amountNeed,
        });

  FreeDeliveryOrderAmount.fromJson(Map<String, dynamic> json) {
    status = int.parse(json['status'].toString());
    if(json['amount'] != null){
      amount = json['amount'].toDouble();
    }

    if(json['percentage'] != null){
      percentage = int.parse(json['percentage'].toString());
    }

    if(json['shipping_cost_saved'] != null){
      shippingCostSaved = json['shipping_cost_saved'].toDouble();
    }

    if(json['amount_need'] != null){
      amountNeed = json['amount_need'].toDouble();
    }


  }

}



class CartModelBody{
  int? productId;
  String? variant;
  String? color;
  Variation? variation;
  int? quantity;

  CartModelBody(
      {this.productId,
        this.variant,
        this.color,
        this.variation,
        this.quantity});
}