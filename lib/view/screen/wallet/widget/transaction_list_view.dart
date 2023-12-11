import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/no_internet_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/shimmer/transaction_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_widget.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatelessWidget {
  final ScrollController? scrollController;
  const TransactionListView({Key? key,  this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if(scrollController!.position.maxScrollExtent == scrollController!.position.pixels
          && Provider.of<WalletTransactionProvider>(context, listen: false).transactionList.isNotEmpty
          && !Provider.of<WalletTransactionProvider>(context, listen: false).isLoading) {
        int? pageSize;
        pageSize = (Provider.of<WalletTransactionProvider>(context, listen: false).transactionPageSize! / 10).ceil();

        if(offset < pageSize) {
          offset++;
          if (kDebugMode) {
            print('end of the page');
          }
          Provider.of<WalletTransactionProvider>(context, listen: false).showBottomLoader();
         Provider.of<WalletTransactionProvider>(context, listen: false).getTransactionList(context, offset,Provider.of<WalletTransactionProvider>(context, listen: false).selectedFilterType, reload: false);
        }
      }

    });

    return Consumer<WalletTransactionProvider>(
      builder: (context, transactionProvider, child) {
        List<WalletTransactioList> transactionList;
        transactionList = transactionProvider.transactionList;

        return Column(crossAxisAlignment: CrossAxisAlignment.start,children: [

          !transactionProvider.isLoading ? (transactionList.isNotEmpty) ?
          ListView.builder(
            shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: transactionList.length,
              itemBuilder: (ctx,index){
                return SizedBox(width: (MediaQuery.of(context).size.width/2)-20,
                    child: TransactionWidget(transactionModel: transactionList[index]));

              }): const NoInternetOrDataScreen(isNoInternet: false, message: 'no_transaction_history',icon: Images.noTransaction) :
          const TransactionShimmer()

        ]);
      },
    );
  }
}

