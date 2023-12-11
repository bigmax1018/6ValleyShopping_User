
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/theme_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TitleRow extends StatelessWidget {
  final String? title;
  final Function? icon;
  final Function? onTap;
  final Duration? eventDuration;
  final bool? isDetailsPage;
  final bool isFlash;
  final Color? titleColor;
  const TitleRow({Key? key, required this.title,this.icon, this.onTap, this.eventDuration, this.isDetailsPage, this.isFlash = false, this.titleColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? days, hours, minutes, seconds;
    if (eventDuration != null) {
      days = eventDuration!.inDays;
      hours = eventDuration!.inHours - days * 24;
      minutes = eventDuration!.inMinutes - (24 * days * 60) - (hours * 60);
      seconds = eventDuration!.inSeconds - (24 * days * 60 * 60) - (hours * 60 * 60) - (minutes * 60);
    }

    return Stack(children: [

      if(eventDuration != null)
      Container(width: MediaQuery.of(context).size.width,height: 70,
          decoration: isFlash? BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall)),
          color: Theme.of(context).primaryColor):null),



      if(eventDuration != null && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)
        Positioned(bottom: -20,left: -6,
            child: SizedBox(width: 60, child: Image.asset(Images.currentShape, opacity: const AlwaysStoppedAnimation(.05),))),

      if(eventDuration != null && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)
      Positioned(top: -1,left: MediaQuery.of(context).size.width/3.3,
          child: SizedBox(width: 35, child: Image.asset(Images.currentShape, opacity: const AlwaysStoppedAnimation(.15),))),

      if(eventDuration != null && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)
      Positioned(right: -2,top: -10,
          child: SizedBox(width: 25, child: Image.asset(Images.currentShape, opacity: const AlwaysStoppedAnimation(.17),))),


      Positioned(
        child: Align(alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [

              Padding(padding: const EdgeInsets.only(left: Dimensions.homePagePadding),
                child: Text(title!, style: titleHeader.copyWith(fontSize: MediaQuery.of(Get.context!).size.width * 0.044,
                    color: titleColor ?? (isFlash? Colors.white: Theme.of(context).textTheme.bodyLarge?.color))),),

              isFlash? Image.asset(Images.flashDeal, scale: 4):const SizedBox(),

                  eventDuration == null ? const Expanded(child: SizedBox.shrink()) :

                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SizedBox(width: 5),
                          TimerBox(time: days, day: getTranslated('day', context), isDetailsPage: isDetailsPage),
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                            child: Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),),
                          TimerBox(time: hours, day: getTranslated('hour', context), isDetailsPage: isDetailsPage),
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                            child: Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),),
                          TimerBox(time: minutes, day: getTranslated('min', context), isDetailsPage: isDetailsPage),
                          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                            child: Text(':', style: TextStyle(color: Theme.of(context).primaryColor)),),
                          TimerBox(time: seconds,day: getTranslated('sec', context), isDetailsPage: isDetailsPage),
                          const SizedBox(width: 5),
                        ]),
                      ),


                  icon != null ? InkWell(
                      onTap: icon as void Function()?,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child:  SvgPicture.asset(
                          Images.filterImage,
                          height: Dimensions.iconSizeDefault,
                          width: Dimensions.iconSizeDefault,
                          color: ColorResources.getPrimary(context),
                        ),
                      )
                  )
                      : const SizedBox.shrink(),

                  onTap != null && isFlash?
                  InkWell(
                    onTap: onTap as void Function()?,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/8,height: MediaQuery.of(context).size.width/6.5,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.paddingSizeExtraSmall),
                            bottomRight: Radius.circular(Dimensions.paddingSizeExtraSmall)),
                            color: Theme.of(context).primaryColor.withOpacity(.3)
                          ),
                        ),
                        Positioned(left: 12,right: 12,top: 18,bottom: 18,
                          child: Container(width: 20,height: 20,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(25)),
                              color: Theme.of(context).primaryColor
                            ),
                              child: const Icon(Icons.arrow_forward_ios_rounded, size: 15, color: Colors.white)),
                        ),
                      ],
                    ),
                  ) :onTap != null && !isFlash ?
                  Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.homePagePadding),
                    child: InkWell(onTap: onTap as void Function()?,
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            isDetailsPage == null ? Text(getTranslated('VIEW_ALL', context)!,
                                style: titilliumRegular.copyWith(color: Provider.of<ThemeProvider>(context, listen: false).darkTheme? Theme.of(context).hintColor : Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeDefault,)) : const SizedBox.shrink(),
                          ]),
                    ),
                  ):
                  const SizedBox.shrink(),
                ]),
        ),
      ),
      ],
    );
  }
}

class TimerBox extends StatelessWidget {
  final int? time;
  final bool isBorder;
  final String? day;
  final bool? isDetailsPage;

  const TimerBox({Key? key, required this.time, this.isBorder = false, this.day,  this.isDetailsPage = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/9.5,height: 55,
      decoration: BoxDecoration(
        border: isBorder ? Border.all(width: 2, color: ColorResources.getPrimary(context)) : null,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 28,height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (isDetailsPage != null && !Provider.of<ThemeProvider>(context, listen: false).darkTheme)? Theme.of(context).primaryColor.withOpacity(.12) : Colors.white,
                borderRadius: BorderRadius.circular(50),),
              child: Text(time! < 10 ? '0$time' : time.toString(),
                style: textMedium.copyWith(
                  color: isBorder ? ColorResources.getPrimary(context) : Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeSmall,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 4.0),
              child: Text(day!, style: textMedium.copyWith(color: isDetailsPage != null ? Theme.of(context).primaryColor : isBorder ?
              ColorResources.getPrimary(context) : Colors.white.withOpacity(.5),
                fontSize: Dimensions.fontSizeSmall,)),
            ),
          ],
        ),
      ),
    );
  }
}
