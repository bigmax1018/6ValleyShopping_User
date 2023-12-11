import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
class TransactionWidget extends StatelessWidget {
  final WalletTransactioList? transactionModel;
  const TransactionWidget({Key? key, this.transactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String type = transactionModel!.transactionType!;
    String? reformatType;
    if (type.contains('_')){
      reformatType = type.replaceAll('_', ' ');
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding,vertical: Dimensions.paddingSizeSmall),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if(transactionModel!.adminBonus! > 0)
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
              Row(children: [
                const Image(image: AssetImage(Images.coinDebit), width: 25,height: 25,),
                const SizedBox(width: Dimensions.paddingSizeSmall,),

                Text( '+' , style: robotoBold.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.fontSizeLarge),),

                Text(PriceConverter.convertPrice(context, transactionModel!.adminBonus), style: robotoBold.copyWith(color: ColorResources.getTextTitle(context), fontSize: Dimensions.fontSizeLarge),),
              ],
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


              Text('admin bonus', style: textRegular.copyWith(color: ColorResources.getHint(context)),),


            ],)),
            Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
              Text(DateConverter.estimatedDateYear(DateTime.parse(transactionModel!.createdAt!)),
                style: textRegular.copyWith(color: ColorResources.getHint(context)),),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


              Text( transactionModel!.credit! > 0 ? 'Credit': 'Debit',
                style: textRegular.copyWith(color: transactionModel!.credit! > 0 ? Colors.green: Colors.red),
              ),
            ],),
          ],),
          if(transactionModel!.adminBonus! > 0)
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Divider(thickness: .4,color: Theme.of(context).hintColor.withOpacity(.8),),),
          Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Row(children: [
                Image(image: AssetImage(transactionModel!.credit! > 0 ? Images.coinDebit: Images.coinCredit), width: 25,height: 25,),
              const SizedBox(width: Dimensions.paddingSizeSmall,),

              Text( transactionModel!.credit! > 0 ? '+': '-',
                style: robotoBold.copyWith(color: ColorResources.getTextTitle(context),
                    fontSize: Dimensions.fontSizeLarge),
              ),

                Text(PriceConverter.convertPrice(context,
                    transactionModel!.credit! > 0 ? transactionModel!.credit: transactionModel!.debit),
                  style: robotoBold.copyWith(color: ColorResources.getTextTitle(context),
                      fontSize: Dimensions.fontSizeLarge),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),



            transactionModel?.paymentMethod != null?
            Text('$reformatType via ${transactionModel?.paymentMethod??''}', style: textRegular.copyWith(color: ColorResources.getHint(context)),):
            Text('$reformatType', style: textRegular.copyWith(color: ColorResources.getHint(context)),),


          ],)),
          Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
            Text(DateConverter.estimatedDateYear(DateTime.parse(transactionModel!.createdAt!)),
              style: textRegular.copyWith(color: ColorResources.getHint(context)),),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall,),


            Text( transactionModel!.credit! > 0 ? 'Credit': 'Debit',
              style: textRegular.copyWith(color: transactionModel!.credit! > 0 ? Colors.green: Colors.red),
            ),
          ],),
          ],),
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Divider(thickness: .4,color: Theme.of(context).hintColor.withOpacity(.8),),),
        ],
      ),);
  }
}
