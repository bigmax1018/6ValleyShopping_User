import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/support/add_ticket_screen.dart';

class SupportTicketTypeWidget extends StatefulWidget {
  const SupportTicketTypeWidget({Key? key}) : super(key: key);

  @override
  State<SupportTicketTypeWidget> createState() => _SupportTicketTypeWidgetState();
}

class _SupportTicketTypeWidgetState extends State<SupportTicketTypeWidget> {
  List<TicketModel> issueTypeList = [
    TicketModel(Images.websiteProblem, 'website_problem'),
    TicketModel(Images.partnerRequest, 'partner_request'),
    TicketModel(Images.complaint, 'complaint'),
    TicketModel(Images.infoQuery, 'info_inquiry'),
  ];

  @override
  Widget build(BuildContext context) {

    return Container(height: 300,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(topRight : Radius.circular(Dimensions.paddingSizeDefault), topLeft: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeLarge, Dimensions.paddingSizeSmall, Dimensions.paddingSizeDefault),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Center(child: Container(width: 40, height: 4,decoration: BoxDecoration(
            color: Theme.of(context).hintColor.withOpacity(.45),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)
          ),),),
          Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
            child: Text(getTranslated('select_your_category', context)!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
              itemCount: issueTypeList.length,
              itemBuilder: (context, index) {
                return InkWell(onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AddTicketScreen(ticketModel: issueTypeList[index])));
                }, child: TypeButton(icon: issueTypeList[index].icon, title: issueTypeList[index].title));
              }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2/1.5
            ),
            ),
          )
        ],),
      ),
    );
  }
}

class TicketModel{
  final String icon;
  final String title;

  TicketModel(this.icon, this.title);
}
class TypeButton extends StatelessWidget {
  final String? icon;
  final String? title;
  const TypeButton({Key? key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(.1), blurRadius: 5, spreadRadius:1, offset: const Offset(1,0))],
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
        border: Border.all(width: .5, color: Theme.of(context).primaryColor.withOpacity(.1))
      ),

      child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Column(mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 20, child: Image.asset(icon!)),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(getTranslated(title, context)!, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
    ],),
      ),);
  }
}
