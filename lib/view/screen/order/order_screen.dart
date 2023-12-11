import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/order_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/custom_app_bar.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/paginated_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_type_button.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/order/widget/order_widget.dart';
import 'package:provider/provider.dart';


class OrderScreen extends StatefulWidget {
  final bool isBacButtonExist;
  const OrderScreen({Key? key, this.isBacButtonExist = true}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController scrollController  = ScrollController();
   bool isGuestMode = !Provider.of<AuthProvider>(Get.context!, listen: false).isLoggedIn();
  @override
  void initState() {
    if(!isGuestMode){
      Provider.of<OrderProvider>(context, listen: false).setIndex(0, notify: false);
      Provider.of<OrderProvider>(context, listen: false).getOrderList(1,'ongoing');

    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
     appBar: CustomAppBar(title: getTranslated('order', context), isBackButtonExist: widget.isBacButtonExist),
      body: isGuestMode ? const NotLoggedInWidget() :

      Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          return Column(children: [


            Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Row(children: [
                OrderTypeButton(text: getTranslated('RUNNING', context), index: 0),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                OrderTypeButton(text: getTranslated('DELIVERED', context), index: 1),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                OrderTypeButton(text: getTranslated('CANCELED', context), index: 2),
              ],),),



              Expanded(
                child: orderProvider.orderModel != null ? (orderProvider.orderModel!.orders != null && orderProvider.orderModel!.orders!.isNotEmpty)?
                SingleChildScrollView(
                  controller: scrollController,
                  child: PaginatedListView(scrollController: scrollController,
                    onPaginate: (int? offset) async{
                      await Provider.of<OrderProvider>(context, listen: false).getOrderList(offset!, orderProvider.selectedType);
                    },
                    totalSize: orderProvider.orderModel?.totalSize,
                    offset: orderProvider.orderModel?.offset != null ? int.parse(orderProvider.orderModel!.offset!):1,
                    itemView: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: orderProvider.orderModel?.orders!.length,
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) => OrderWidget(orderModel: orderProvider.orderModel?.orders![index]),
                    ),

                  ),
                ) : const NoInternetOrDataScreen(isNoInternet: false, icon: Images.noOrder, message: 'no_order_found',) : const OrderShimmer()
              )

            ],
          );
        }
      ),
    );
  }
}




