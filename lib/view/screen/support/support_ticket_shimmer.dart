import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/provider/support_ticket_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SupportTicketShimmer extends StatelessWidget {
  const SupportTicketShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
      itemCount: 10,
      itemBuilder: (context, index) {

        return Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Theme.of(context).hintColor, width: 0.2),
          ),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).cardColor,
            highlightColor: Colors.grey[100]!,
            enabled: Provider.of<SupportTicketProvider>(context).supportTicketList == null,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(height: 10, width: 100, color: ColorResources.white),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Container(height: 15, color: ColorResources.white),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Row(children: [
                Container(height: 15, width: 15, color: ColorResources.white),
                const SizedBox(width: Dimensions.paddingSizeSmall),
                Container(height: 15, width: 50, color: ColorResources.white),
                const Expanded(child: SizedBox.shrink()),
                Container(height: 30, width: 70, color: ColorResources.white),
              ]),
            ]),
          ),
        );

      },
    );
  }
}