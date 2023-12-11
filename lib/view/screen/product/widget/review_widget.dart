import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/review_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_details_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/image_diaglog.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  const ReviewWidget({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: Images.placeholder, height: Dimensions.chooseReviewImageSize,
              width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover,
              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${
                  reviewModel.customer != null ? reviewModel.customer!.image : ''
              }',
              imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: Dimensions.chooseReviewImageSize,
                  width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),


          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text('${reviewModel.customer == null ? getTranslated('user_not_exist', context): reviewModel.customer!.fName ?? ''} ${
                  reviewModel.customer == null ? '' : reviewModel.customer!.lName ?? ''}',
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            ]),


            Row(children: [
              const Icon(Icons.star,color: Colors.orange),

              Text('${reviewModel.rating!.toDouble()} /5',
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
                maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ]),
          ]),
        ]),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
          child: Text(reviewModel.comment??'', textAlign: TextAlign.left,
            style: titilliumRegular.copyWith(color: Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeDefault),
            maxLines: 3, overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        (reviewModel.attachment != null && reviewModel.attachment!.isNotEmpty) ? SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: reviewModel.attachment!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (_)=> ImageDialog(imageUrl: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.reviewImageUrl}/review/${reviewModel.attachment![index]}'));
                },
                child: Container(
                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder, height: Dimensions.chooseReviewImageSize,
                      width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover,
                      image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.reviewImageUrl}/review/${reviewModel.attachment![index]}',
                      imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder,
                          height: Dimensions.chooseReviewImageSize, width: Dimensions.chooseReviewImageSize, fit: BoxFit.cover),
                    ),
                  ),
                ),
              );
            },
          ),
        ) : const SizedBox(),
      ]),
    );
  }
}

class ReviewShimmer extends StatelessWidget {
  const ReviewShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: Provider.of<ProductDetailsProvider>(context).reviewList == null,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const CircleAvatar(
            maxRadius: 15,
            backgroundColor: ColorResources.sellerText,
            child: Icon(Icons.person),
          ),
          const SizedBox(width: 5),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(height: 10, width: 50, color: ColorResources.white),
              const SizedBox(width: 5),
              const RatingBar(rating: 0, size: 12),
            ]),
            Container(height: 10, width: 50, color: ColorResources.white),
          ]),
        ]),
        const SizedBox(height: 5),
        Container(height: 20, width: 200, color: ColorResources.white),
      ]),
    );
  }
}

