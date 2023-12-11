import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/helper/date_converter.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/notification_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_image.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/notification/widget/notification_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {

  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: getTranslated('notification', context), onBackPressed: (){
        if(Navigator.of(context).canPop()){
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));

        }
      },),
      body: Consumer<NotificationProvider>(
        builder: (context, notification, child) {
          return notification.notificationModel != null ? (notification.notificationModel!.notification != null && notification.notificationModel!.notification!.isNotEmpty) ?
          RefreshIndicator(
            onRefresh: () async {
              await Provider.of<NotificationProvider>(context, listen: false).getNotificationList(1);
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: PaginatedListView(
                 scrollController: scrollController,
                onPaginate: (int? offset) {  },
                totalSize: notification.notificationModel?.totalSize,
                offset:  notification.notificationModel?.offset,
                itemView: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notification.notificationModel!.notification!.length,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap:(){
                        notification.seenNotification(notification.notificationModel!.notification![index].id!);
                        showModalBottomSheet(backgroundColor: Colors.transparent,
                            context: context, builder: (context) => NotificationDialog(notificationModel: notification.notificationModel!.notification![index]));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                        color: Theme.of(context).cardColor,
                        child: ListTile(
                          leading: Stack(children: [
                              ClipRRect(borderRadius: BorderRadius.circular(40),
                                child: Container(decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15), width: .35),
                                  borderRadius: BorderRadius.circular(40)),
                                  child: CustomImage(width: 50,height: 50,
                                    image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationModel!.notification![index].image}'),
                                ),),
                            if(notification.notificationModel!.notification![index].seen == null)
                            CircleAvatar(backgroundColor: Theme.of(context).colorScheme.error.withOpacity(.75),radius: 3)
                            ],
                          ),
                          title: Text(notification.notificationModel!.notification![index].title??'',
                              style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                          )),
                          subtitle: Text(DateConverter.localDateToIsoStringAMPM(DateTime.parse(notification.notificationModel!.notification![index].createdAt!)),
                            style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: ColorResources.getHint(context)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ) : const NoInternetOrDataScreen(isNoInternet: false,
            message: 'no_notification',
            icon: Images.noNotification,) : const NotificationShimmer();
        },
      )
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            enabled: Provider.of<NotificationProvider>(context).notificationModel == null,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.white),
              subtitle: Container(height: 10, width: 50, color: ColorResources.white),
            ),
          ),
        );
      },
    );
  }
}

