import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/support_ticket_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/support_ticket_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/checkout/widget/shipping_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/support/support_conversation_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class SupportTicketWidget extends StatelessWidget {
  final SupportTicketModel supportTicketModel;
   const SupportTicketWidget({Key? key, required this.supportTicketModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, Dimensions.paddingSizeSmall, 0),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          extentRatio: .25,
          motion: const ScrollMotion(),
          children: [
            if(supportTicketModel.status != 'close')
            SlidableAction(
              onPressed: (value){
                Provider.of<SupportTicketProvider>(context, listen: false).closeSupportTicket(supportTicketModel.id);
              },
              backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.05),
              foregroundColor: Theme.of(context).colorScheme.error.withOpacity(.75),
              icon: CupertinoIcons.clear,

              label: getTranslated('close', context),
            ),
          ],
        ),
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SupportConversationScreen(
            supportTicketModel: supportTicketModel,))),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25), width: .5)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [


              Row(children: [
                SizedBox(width: 15, child: Image.asset(supportTicketModel.type?.toLowerCase() == 'website problem'? Images.websiteProblem :
                supportTicketModel.type == 'Complaint'? Images.complaint : supportTicketModel.type == 'Partner request'? Images.partnerRequest : Images.infoQuery)),
                const SizedBox(width: Dimensions.paddingSizeSmall,),
                Expanded(child: Text(supportTicketModel.type!, style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(.75)))),

                Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                        color: supportTicketModel.status == 'open' ? ColorResources.getGreen(context).withOpacity(.125) :supportTicketModel.status == 'pending' ?
                        Theme.of(context).primaryColor.withOpacity(.125) : Theme.of(context).colorScheme.error.withOpacity(.125)),

                    child: Text(supportTicketModel.status == 'pending' ? getTranslated('pending', context)! :
                    supportTicketModel.status == 'open' ? getTranslated('open', context)! :
                    getTranslated('closed', context)!,
                        style: textRegular.copyWith(color: supportTicketModel.status == 'open' ?
                        ColorResources.getGreen(context) : supportTicketModel.status == 'pending' ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.error)))]),

              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeEight),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text('${getTranslated('topic', context)} : ', style: textBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                  Expanded(child: Text(supportTicketModel.subject!, style: textRegular)),
                ],
                ),
              ),




              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: '${getTranslated('priority', context)}',
                        style: textRegular.copyWith()),
                    const TextSpan(text: ': '),
                    TextSpan(text: supportTicketModel.priority!.capitalize(), style: textRegular.copyWith(color: supportTicketModel.priority == 'High'?
                    Colors.amber : supportTicketModel.priority == 'Urgent'? Theme.of(context).colorScheme.error : (supportTicketModel.priority == 'Low' || supportTicketModel.priority == 'low')? Theme.of(context).primaryColor : Colors.greenAccent))
                  ])),
                  Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(supportTicketModel.createdAt!)),
                      style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor)),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
