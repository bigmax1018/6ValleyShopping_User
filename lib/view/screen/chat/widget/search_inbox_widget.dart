import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/chat_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/show_custom_snakbar.dart';
import 'package:provider/provider.dart';


class SearchInboxWidget extends StatefulWidget {
  final String? hintText;

  const SearchInboxWidget({Key? key, required this.hintText}) : super(key: key);

  @override
  State<SearchInboxWidget> createState() => _SearchInboxWidgetState();
}

class _SearchInboxWidgetState extends State<SearchInboxWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipRRect(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          child: SizedBox(height: 50 , width: MediaQuery.of(context).size.width)),

      Container(width : MediaQuery.of(context).size.width, height:  50 ,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            border: Border.all(color: Theme.of(context).hintColor.withOpacity(.15))),
        child: Row(children: [
          Expanded(child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(Dimensions.paddingSizeDefault))),

            child: Padding(padding:  const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall,
                horizontal: Dimensions.paddingSizeSmall),

              child: TextFormField(controller: searchController,
                textInputAction: TextInputAction.search,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                onFieldSubmitted: (val){
                  Provider.of<ChatProvider>(context, listen: false).searchChat(context, searchController.text.trim());
                  //Provider.of<ProductProvider>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, context, search: searchController.text.trim());
                },
                onChanged: (val){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  isDense: true,

                  contentPadding: EdgeInsets.zero,
                  suffixIconConstraints: const BoxConstraints(maxHeight: 25),
                  hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor),
                  border: InputBorder.none,
                  suffixIcon: searchController.text.isNotEmpty? InkWell(
                      onTap: (){
                        setState(() {
                          searchController.clear();
                          Provider.of<ChatProvider>(context, listen: false).getChatList(context, 1);
                        });

                      },
                      child: Padding(padding: const EdgeInsets.only(bottom: 3.0),
                        child: Icon(Icons.clear, color: ColorResources.getChatIcon(context)),
                      )):const SizedBox(),
                ),
              ),
            ),

          ),
          ),

          InkWell(
            onTap:(){
              if(searchController.text.trim().isEmpty){
                showCustomSnackBar(getTranslated('enter_somethings', context), context);
              }
              else{
                Provider.of<ChatProvider>(context, listen: false).searchChat(context, searchController.text.trim());
                //Provider.of<ProductProvider>(context, listen: false).getSellerProductList(widget.sellerId.toString(), 1, context, search: searchController.text.trim());

              }
            },
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(padding: const EdgeInsets.all(10),
                width: 45,height: 50 ,decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
                child:  Image.asset(Images.search, color: Colors.white),
              ),
            ),
          )


        ]),
      ),
    ]);
  }
}
