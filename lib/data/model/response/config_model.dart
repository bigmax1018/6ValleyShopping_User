class ConfigModel {
  String? brandSetting;
  String? digitalProductSetting;
  int? systemDefaultCurrency;
  bool? digitalPayment;
  bool? cashOnDelivery;
  String? sellerRegistration;
  String? posActive;
  String? companyPhone;
  String? companyEmail;
  String? companyLogo;
  int? deliveryCountryRestriction;
  int? deliveryZipCodeAreaRestriction;
  BaseUrls? baseUrls;
  StaticUrls? staticUrls;
  String? aboutUs;
  String? privacyPolicy;
  List<Faq>? faq;
  String? termsConditions;
  RefundPolicy? refundPolicy;
  RefundPolicy? returnPolicy;
  RefundPolicy? cancellationPolicy;
  List<CurrencyList>? currencyList;
  String? currencySymbolPosition;
  String? businessMode;
  bool? maintenanceMode;
  List<Language>? language;
  List<Colors>? colors;
  List<String>? unit;
  String? shippingMethod;
  bool? emailVerification;
  bool? phoneVerification;
  String? countryCode;
  List<SocialLogin>? socialLogin;
  String? currencyModel;
  String? forgotPasswordVerification;
  Announcement? announcement;
  String? softwareVersion;
  int? decimalPointSettings;
  String? inhouseSelectedShippingType;
  int? billingInputByCustomer;
  int? minimumOrderLimit;
  int? walletStatus;
  int? loyaltyPointStatus;
  int? loyaltyPointExchangeRate;
  int? loyaltyPointMinimumPoint;
  List<PaymentMethods>? paymentMethods;
  OfflinePayment? offlinePayment;
  String? paymentMethodImagePath;
  String? refEarningStatus;
  String? activeTheme;
  List<PopularTags>? popularTags;
  int? guestCheckOut;
  int? addFundsToWallet;
  double? minimumAddFundAmount;
  double? maximumAddFundAmount;
  String? refSignup;
  int? orderVerification;

  ConfigModel(
      {this.brandSetting,
        this.digitalProductSetting,
        this.systemDefaultCurrency,
        this.digitalPayment,
        this.cashOnDelivery,
        this.sellerRegistration,
        this.posActive,
        this.companyPhone,
        this.companyEmail,
        this.companyLogo,
        this.deliveryCountryRestriction,
        this.deliveryZipCodeAreaRestriction,
        this.baseUrls,
        this.staticUrls,
        this.aboutUs,
        this.privacyPolicy,
        this.faq,
        this.termsConditions,
        this.refundPolicy,
        this.returnPolicy,
        this.cancellationPolicy,
        this.currencyList,
        this.currencySymbolPosition,
        this.businessMode,
        this.maintenanceMode,
        this.language,
        this.colors,
        this.unit,
        this.shippingMethod,
        this.emailVerification,
        this.phoneVerification,
        this.countryCode,
        this.socialLogin,
        this.currencyModel,
        this.forgotPasswordVerification,
        this.announcement,
        this.softwareVersion,
        this.decimalPointSettings,
        this.inhouseSelectedShippingType,
        this.billingInputByCustomer,
        this.minimumOrderLimit,
        this.walletStatus,
        this.loyaltyPointStatus,
        this.loyaltyPointExchangeRate,
        this.loyaltyPointMinimumPoint,
        this.paymentMethods,
        this.offlinePayment,
        this.paymentMethodImagePath,
        this.refEarningStatus,
        this.activeTheme,
        this.popularTags,
        this.guestCheckOut,
        this.addFundsToWallet,
        this.minimumAddFundAmount,
        this.maximumAddFundAmount,
        this.refSignup,
        this.orderVerification
      });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    brandSetting = json['brand_setting'];
    digitalProductSetting = json['digital_product_setting'];
    systemDefaultCurrency = json['system_default_currency'];
    digitalPayment = json['digital_payment'];
    cashOnDelivery = json['cash_on_delivery'];
    sellerRegistration = json['seller_registration'];
    posActive = json['pos_active'];
    companyPhone = json['company_phone'].toString();
    companyEmail = json['company_email'];
    companyLogo = json['company_logo'];
    if(json['delivery_country_restriction'] != null){
      deliveryCountryRestriction = json['delivery_country_restriction'];
    }else{
      deliveryCountryRestriction = 0;
    }

    if(json['delivery_zip_code_area_restriction'] != null){
      deliveryZipCodeAreaRestriction = json['delivery_zip_code_area_restriction'];
    }else{
      deliveryZipCodeAreaRestriction = 0;
    }

    baseUrls = json['base_urls'] != null ? BaseUrls.fromJson(json['base_urls']) : null;
    staticUrls = json['static_urls'] != null ? StaticUrls.fromJson(json['static_urls']) : null;
    aboutUs = json['about_us'];
    privacyPolicy = json['privacy_policy'];
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
    termsConditions = json['terms_&_conditions'];
    refundPolicy = json['refund_policy'] != null ? RefundPolicy.fromJson(json['refund_policy']) : null;
    returnPolicy = json['return_policy'] != null ? RefundPolicy.fromJson(json['return_policy']) : null;
    cancellationPolicy = json['cancellation_policy'] != null ? RefundPolicy.fromJson(json['cancellation_policy']) : null;
    if (json['currency_list'] != null) {
      currencyList = <CurrencyList>[];
      json['currency_list'].forEach((v) {
        currencyList!.add(CurrencyList.fromJson(v));
      });
    }
    currencySymbolPosition = json['currency_symbol_position'];
    businessMode = json['business_mode'];
    maintenanceMode = json['maintenance_mode'];
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(Colors.fromJson(v));
      });
    }
    unit = json['unit'].cast<String>();
    shippingMethod = json['shipping_method'];
    emailVerification = json['email_verification'];
    phoneVerification = json['phone_verification'];
    countryCode = json['country_code'];
    if (json['social_login'] != null) {
      socialLogin = <SocialLogin>[];
      json['social_login'].forEach((v) {
        socialLogin!.add(SocialLogin.fromJson(v));
      });
    }
    currencyModel = json['currency_model'];
    forgotPasswordVerification = json['forgot_password_verification'];
    announcement = json['announcement'] != null ? Announcement.fromJson(json['announcement']) : null;
    softwareVersion = json['software_version'];
    if(json['decimal_point_settings'] != null){
      decimalPointSettings = int.parse(json['decimal_point_settings'].toString());
    }else{
      decimalPointSettings = 1;
    }

    inhouseSelectedShippingType = json['inhouse_selected_shipping_type'];
    billingInputByCustomer = json['billing_input_by_customer'];
    minimumOrderLimit = json['minimum_order_limit'];
    walletStatus = json['wallet_status'];
    loyaltyPointStatus = json['loyalty_point_status'];
    loyaltyPointExchangeRate = json['loyalty_point_exchange_rate'];
    loyaltyPointMinimumPoint = json['loyalty_point_minimum_point'];
    if (json['payment_methods'] != null) {
      paymentMethods = <PaymentMethods>[];
      json['payment_methods'].forEach((v) {
        paymentMethods!.add(PaymentMethods.fromJson(v));
      });
    }
    offlinePayment = json['offline_payment'] != null ? OfflinePayment.fromJson(json['offline_payment']) : null;
    paymentMethodImagePath = json['payment_method_image_path'];
    refEarningStatus = json['ref_earning_status'].toString();
    activeTheme = json['active_theme'];
    if (json['popular_tags'] != null) {
      popularTags = <PopularTags>[];
      json['popular_tags'].forEach((v) {
        popularTags!.add(PopularTags.fromJson(v));
      });
    }
    if(json['guest_checkout'] != null){
      guestCheckOut = int.parse(json['guest_checkout'].toString());
    }else{
      guestCheckOut = 0;
    }
    if(json['add_funds_to_wallet'] != null){
      addFundsToWallet = int.parse(json['add_funds_to_wallet'].toString());
    }else{
      addFundsToWallet = 0;
    }
    if(json['minimum_add_fund_amount'] != null){
      minimumAddFundAmount = double.parse(json['minimum_add_fund_amount'].toString());
    }else{
      minimumAddFundAmount = 0;
    }

    if(json['maximum_add_fund_amount'] != null){
      maximumAddFundAmount = double.parse(json['maximum_add_fund_amount'].toString());
    }else{
      maximumAddFundAmount = 0;
    }
    refSignup = json['referral_customer_signup_url'];

    if(json['order_verification'] != null){
      try{
        orderVerification = json['order_verification'];
      }catch(e){
        orderVerification = int.parse(json['order_verification'].toString());
      }
    }
  }

}

class BaseUrls {
  String? productImageUrl;
  String? productThumbnailUrl;
  String? digitalProductUrl;
  String? brandImageUrl;
  String? customerImageUrl;
  String? bannerImageUrl;
  String? categoryImageUrl;
  String? reviewImageUrl;
  String? sellerImageUrl;
  String? shopImageUrl;
  String? notificationImageUrl;
  String? deliveryManImageUrl;

  BaseUrls(
      {this.productImageUrl,
        this.productThumbnailUrl,
        this.digitalProductUrl,
        this.brandImageUrl,
        this.customerImageUrl,
        this.bannerImageUrl,
        this.categoryImageUrl,
        this.reviewImageUrl,
        this.sellerImageUrl,
        this.shopImageUrl,
        this.notificationImageUrl,
        this.deliveryManImageUrl});

  BaseUrls.fromJson(Map<String, dynamic> json) {
    productImageUrl = json['product_image_url'];
    productThumbnailUrl = json['product_thumbnail_url'];
    digitalProductUrl = json['digital_product_url'];
    brandImageUrl = json['brand_image_url'];
    customerImageUrl = json['customer_image_url'];
    bannerImageUrl = json['banner_image_url'];
    categoryImageUrl = json['category_image_url'];
    reviewImageUrl = json['review_image_url'];
    sellerImageUrl = json['seller_image_url'];
    shopImageUrl = json['shop_image_url'];
    notificationImageUrl = json['notification_image_url'];
    deliveryManImageUrl = json['delivery_man_image_url'];
  }

}

class StaticUrls {
  String? contactUs;
  String? brands;
  String? categories;
  String? customerAccount;

  StaticUrls(
      {this.contactUs, this.brands, this.categories, this.customerAccount});

  StaticUrls.fromJson(Map<String, dynamic> json) {
    contactUs = json['contact_us'];
    brands = json['brands'];
    categories = json['categories'];
    customerAccount = json['customer_account'];
  }


}

class Faq {
  int? id;
  String? question;
  String? answer;
  int? ranking;
  int? status;
  String? createdAt;
  String? updatedAt;

  Faq(
      {this.id,
        this.question,
        this.answer,
        this.ranking,
        this.status,
        this.createdAt,
        this.updatedAt});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    ranking = json['ranking'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class RefundPolicy {
  int? status;
  String? content;

  RefundPolicy({this.status, this.content});

  RefundPolicy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    content = json['content'];
  }

}

class CurrencyList {
  int? id;
  String? name;
  String? symbol;
  String? code;
  double? exchangeRate;
  int? status;
  String? createdAt;
  String? updatedAt;

  CurrencyList(
      {this.id,
        this.name,
        this.symbol,
        this.code,
        this.exchangeRate,
        this.status,
        this.createdAt,
        this.updatedAt});

  CurrencyList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    symbol = json['symbol'];
    code = json['code'];
    exchangeRate = json['exchange_rate'].toDouble();
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Language {
  String? code;
  String? name;

  Language({this.code, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

}

class Colors {
  int? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;

  Colors({this.id, this.name, this.code, this.createdAt, this.updatedAt});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class SocialLogin {
  String? loginMedium;
  bool? status;

  SocialLogin({this.loginMedium, this.status});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    loginMedium = json['login_medium'];
    status = json['status'];
  }

}

class Announcement {
  String? status;
  String? color;
  String? textColor;
  String? announcement;

  Announcement({this.status, this.color, this.textColor, this.announcement});

  Announcement.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    color = json['color'];
    textColor = json['text_color'];
    announcement = json['announcement'];
  }

}

class PaymentMethods {
  String? keyName;
  AdditionalDatas? additionalDatas;

  PaymentMethods({this.keyName, this.additionalDatas});

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    keyName = json['key_name'];
    additionalDatas = json['additional_datas'] != null ? AdditionalDatas.fromJson(json['additional_datas']) : null;
  }

}

class AdditionalDatas {
  String? gatewayTitle;
  String? gatewayImage;

  AdditionalDatas({this.gatewayTitle, this.gatewayImage});

  AdditionalDatas.fromJson(Map<String, dynamic> json) {
    gatewayTitle = json['gateway_title'];
    gatewayImage = json['gateway_image'];
  }

}

class OfflinePayment {
  String? name;
  String? image;

  OfflinePayment({this.name, this.image});

  OfflinePayment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

}

class PopularTags {
  int? id;
  String? tag;
  String? createdAt;
  String? updatedAt;

  PopularTags(
      {this.id, this.tag,  this.createdAt, this.updatedAt});

  PopularTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
