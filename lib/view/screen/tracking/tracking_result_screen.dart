import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/tracking/painter/line_dashed_painter.dart';
import 'package:provider/provider.dart';

class TrackingResultScreen extends StatefulWidget {
  final String orderID;
  const TrackingResultScreen({Key? key, required this.orderID}) : super(key: key);

  @override
  State<TrackingResultScreen> createState() => _TrackingResultScreenState();
}

class _TrackingResultScreenState extends State<TrackingResultScreen> {
  @override
  void initState() {
    Provider.of<OrderProvider>(context, listen: false).initTrackingInfo(widget.orderID);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    List<String> statusList = ['pending', 'confirmed', 'processing', 'out_for_delivery', 'delivered'];


    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('TRACK_ORDER', context)),
      body: Column(children: [


          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, tracking, child) {
                String? status = tracking.trackingModel != null ? tracking.trackingModel!.orderStatus : '';
                return tracking.trackingModel != null?
                ListView( children: [

                  Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: RichText(text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: '${getTranslated('your_order', context)}', style: textBold.copyWith(color: Theme.of(context).textTheme.bodyLarge?.color)),
                          TextSpan(text: '  #${widget.orderID}', style: textBold.copyWith(color: Theme.of(context).primaryColor)),
                        ],
                      ),),
                    ),
                  ),

                  CustomStepper(title: getTranslated('order_placed', context),
                      icon: Images.orderIdIcon,
                      checked: true,
                      dateTime: tracking.trackingModel!.createdAt),


                  CustomStepper(title: '${getTranslated('order_confirmed', context)}',
                      icon: Images.orderConfirmedIcon,
                    checked: (status == statusList[1] || status == statusList[2] || status == statusList[3] ||status == statusList[4]),
                  ),


                  CustomStepper(
                      icon: Images.shipment,
                      title: '${getTranslated('preparing_for_shipment', context)}',
                    checked: (status == statusList[2] || status == statusList[3] ||status == statusList[4]),
                  ),


                  CustomStepper(
                      icon: Images.outForDeliveryIcon,
                      title: '${getTranslated('order_is_on_the_way', context)}',
                    checked: (status == statusList[3] ||status == statusList[4]),
                  ),

                  CustomStepper(
                      icon: Images.deliveredIcon,
                      title: '${getTranslated('order_delivered', context)}',
                      checked: (status == statusList[4]),
                      isLastItem: true),
                ],
                ): const Center(child: CircularProgressIndicator(),);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomStepper extends StatelessWidget {
  final String? title;
  final bool isLastItem;
  final String icon;
  final bool checked;
  final String? dateTime;
  const CustomStepper({Key? key, required this.title,
    this.isLastItem = false, required this.icon, this.checked = false, this.dateTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color myColor;
    if (checked) {
      myColor = Provider.of<ThemeProvider>(context, listen: false).darkTheme? Colors.white  : Theme.of(context).primaryColor;
    } else {
      myColor = Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor.withOpacity(.75) : Theme.of(context).hintColor;
    }
    return Container(height: 100,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Container(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                      color: Theme.of(context).primaryColor.withOpacity(.075)),
                    child: SizedBox(height: 30,child: Image.asset(icon, color: myColor)),)),

                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  checked?
                    Text(title!, style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)):
                    Text(title!, style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).hintColor)),
                    if(dateTime != null)
                    Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
                          SizedBox(height: 20, child: Image.asset(Images.dateTimeIcon)),
                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                          Text(DateConverter.dateTimeStringToDateAndTime(dateTime!), style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                        ],
                      ),
                    ),
                  ],
                )]),

              isLastItem ? const SizedBox.shrink() :
              Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall, left: 35),
                child: CustomPaint(painter: LineDashedPainter(myColor))),
              ],
            ),
          ),
          if(checked)
          Padding(padding: const EdgeInsets.all(8.0),
            child: SizedBox(child: Icon(CupertinoIcons.checkmark_alt_circle_fill, color: Theme.of(context).primaryColor))),

        ],
      ),
    );
  }
}
