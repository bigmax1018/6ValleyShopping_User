import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/remove_wish_list_bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/controller/compare_controller.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/compare/widget/custom_top_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/search/widget/partial_matched.dart';
import 'package:provider/provider.dart';

class CompareProductScreen extends StatefulWidget {
  const CompareProductScreen({Key? key}) : super(key: key);

  @override
  State<CompareProductScreen> createState() => _CompareProductScreenState();
}

class _CompareProductScreenState extends State<CompareProductScreen> {
  @override
  void initState() {
    Provider.of<CompareProvider>(context, listen: false).getCompareList();
    Provider.of<CompareProvider>(context, listen: false).getAttributeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: '${getTranslated('compare_list', context)}'),
      body: Consumer<CompareProvider>(
        builder: (context, compareProvider,_) {
          return Column(children: [

            if(compareProvider.compareModel != null && compareProvider.compareModel!.compareLists != null&& compareProvider.compareModel!.compareLists!.isNotEmpty)
              InkWell(onTap: ()=> showModalBottomSheet(context: context, builder: (_)=> const RemoveFromCompareListBottomSheet()),
                child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const SizedBox(),
                    Text('${getTranslated('clear_all', context)}', style: textRegular.copyWith(color: Theme.of(context).colorScheme.error))]))),

              Expanded(child: Padding(padding: const EdgeInsets.all(8.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.start, children: [
                        const SizedBox(height: 260),
                        Container(width: 80,height: 48,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${getTranslated('price', context)}')])),
                        Container(width: 80,height: 48,
                          decoration: BoxDecoration(color: Theme.of(context).cardColor),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${getTranslated('color', context)}')])),


                        SizedBox(width: 80,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: compareProvider.attributeList?.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index){
                              return Container(height: 48,
                                decoration: BoxDecoration(color: index.isOdd? Theme.of(context).cardColor:Theme.of(context).colorScheme.background),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Text('${compareProvider.attributeList?[index].name}')]),
                              );
                            })),




                        Container(width: 80,height: 48,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${getTranslated('brand', context)}')])),

                        Container(width: 80,height: 48,
                          decoration: BoxDecoration(color: Theme.of(context).cardColor),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text('${getTranslated('ratings', context)}')])),

                      ],),
                      Expanded(
                        child: ListView(scrollDirection: Axis.horizontal,
                          children: [
                            (compareProvider.compareModel != null && compareProvider.compareModel!.compareLists != null && compareProvider.compareModel!.compareLists!.isNotEmpty)?
                            SizedBox(width: Dimensions.compareCardWidget, child: CompareCard(compareId: compareProvider.compareModel?.compareLists?[0].id, product: compareProvider.compareModel?.compareLists?[0].product)):
                            const SizedBox(width: Dimensions.compareCardWidget,child: CompareCard(product: null)),
                            (compareProvider.compareModel != null && compareProvider.compareModel!.compareLists != null && compareProvider.compareModel!.compareLists!.length > 1)?
                            SizedBox(width: Dimensions.compareCardWidget,child: CompareCard(compareId: compareProvider.compareModel?.compareLists?[1].id, product: compareProvider.compareModel?.compareLists?[1].product)):
                            const SizedBox(width: Dimensions.compareCardWidget,child: CompareCard(product: null)),
                            (compareProvider.compareModel != null && compareProvider.compareModel!.compareLists != null && compareProvider.compareModel!.compareLists!.length > 2)?
                            SizedBox(width: Dimensions.compareCardWidget,child: CompareCard(compareId: compareProvider.compareModel?.compareLists?[2].id, product: compareProvider.compareModel?.compareLists?[2].product)):
                            const SizedBox(width: Dimensions.compareCardWidget,child: CompareCard(product: null)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

class CompareCard extends StatelessWidget {
  final Product? product;
  final int? compareId;
  const CompareCard({Key? key, required this.product, this.compareId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<CompareProvider>(
      builder: (context, compareProvider, _) {
        return Padding(padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if(product != null)
            InkWell(onTap: ()=> Provider.of<CompareProvider>(context, listen: false).addCompareList(product!.id!),
              child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
                Icon(Icons.clear, color: Theme.of(context).hintColor, size: 20,)]),),

            product != null?
            SizedBox(height: 65,
              child: Padding(padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeExtraSmall),
                child: Text(product?.name??'', maxLines: 2,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(color: Theme.of(context).hintColor)),),
            ):const SizedBox(height: 85,),

            ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.5) : Theme.of(context).primaryColor.withOpacity(.25), width: .5),
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(height: Dimensions.paddingSizeSmall,),

                    Stack(children: [
                        Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, 0, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall),
                          child: Container(height: 155,
                            decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25), width: .5),
                              color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.5) : ColorResources.getIconBg(context),
                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                            child: ClipRRect(borderRadius: const BorderRadius.all( Radius.circular(Dimensions.paddingSizeSmall)),
                              child: CustomImage(image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.productThumbnailUrl}/${product?.thumbnail}',
                                  height: 180,width: 200, placeholder: Images.emptyProduct)

                            ),
                          ),
                        ),
                        Positioned(right: 10,top: 0,
                            child: InkWell(onTap: () {
                              showCustomTopSheet(context,widget : Column(children: [
                                  const SizedBox(height: 30),
                                  Row(children: [Expanded(child: Material(
                                    child: Container(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(color: Theme.of(context).canvasColor,
                                          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, 1),)]),
                                      child: SearchSuggestion(fromCompare: true,id: compareId))))],),
                                const SizedBox(height: Dimensions.paddingSizeDefault)]));
                            },
                              child: Card(elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                                    width: 30, height:30, child: Padding(
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                      child: Image.asset(Images.search,
                                          color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor.withOpacity(.25))))),
                            ))
                      ],
                    ),
                  Container(height: 48, decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                          child: Text(product != null ? PriceConverter.convertPrice(context , product!.unitPrice) : ''),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 48,padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                    color: Theme.of(context).cardColor),
                    child: product != null? product!.colors!.isNotEmpty?
                    Center(
                      child: ListView.builder(
                        itemCount: product!.colors!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String colorString = '0xff${product!.colors![index].code!.substring(1, 7)}';
                          return Center(
                            child: Container(decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)),
                              child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                child: Container(height: 15, width: 15,
                                  padding: const EdgeInsets.all( Dimensions.paddingSizeExtraSmall),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(color: Color(int.parse(colorString)),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ):const Center(child: SizedBox(height: 48,width: 200,child: Center(child: Text('No Color')))):const SizedBox(),
                  ),

                  SizedBox(width: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: compareProvider.attributeList?.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            List<List<String>> variation= [];
                            if(product != null && product!.choiceOptions != null && product!.choiceOptions!.isNotEmpty){
                              for(int i =0; i<compareProvider.attributeList!.length; i++){
                                for(int j =0 ; j< product!.choiceOptions!.length; j++){
                                  if(compareProvider.attributeList![i].name == product!.choiceOptions![j].title){
                                    variation.insert(i, product!.choiceOptions![j].options!);
                                  }else{
                                    variation.insert(i, ['No ${compareProvider.attributeList![i].name}']);
                                  }
                                }
                              }
                            }


                            return (product != null && product!.choiceOptions != null &&  product!.choiceOptions!.isNotEmpty)?
                            Container(height: 48,width: 200,
                              decoration: BoxDecoration(color: index.isOdd? Theme.of(context).cardColor:Theme.of(context).colorScheme.background),
                              child: variation.isNotEmpty?
                              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                                child: Center(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: variation[index].length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                      itemBuilder: (context, varIndex){
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                        child: Container(height: 48,
                                          decoration: BoxDecoration(color: index.isOdd? Theme.of(context).cardColor:Theme.of(context).colorScheme.background),
                                          child: Text(variation[index][varIndex].trim()),
                                        ),
                                      );

                                  }),
                                ),
                              ):const SizedBox(),
                            ): Center(child: SizedBox(height: 48,width: 200,child: Center(child: Text('No ${compareProvider.attributeList![index].name}'))));
                          })),




                  Container(height: 48, decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
                    child:  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                        child: Text(product?.brand?.name??''))])),

                  ClipRRect(borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Dimensions.paddingSizeSmall)),
                    child: Container(height: 48,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Icon(Icons.star_rate_rounded, color: Colors.orange,size: 20),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Text(product != null ?double.parse(product!.rating != null && product!.rating!.isNotEmpty? product!.rating![0].average! : "0").toStringAsFixed(1):'',
                                  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),),



                            Text(product != null?'(${product!.reviewCount.toString()})' :'',
                                style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),

                          ]),
                    ),
                  ),
                  ],
                ),
              ),
            ),

          ],),
        );
      }
    );
  }
}
