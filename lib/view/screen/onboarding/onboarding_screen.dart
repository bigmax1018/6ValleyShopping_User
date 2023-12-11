import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/onboarding_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/splash_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/auth/auth_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatelessWidget {
  final Color indicatorColor;
  final Color selectedIndicatorColor;

  OnBoardingScreen({Key? key,
    this.indicatorColor = Colors.grey,
    this.selectedIndicatorColor = Colors.black,
  }) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Provider.of<OnBoardingProvider>(context, listen: false).initBoardingList(context);


    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [

          Consumer<OnBoardingProvider>(
            builder: (context, onBoardingList, child) => ListView(
              children: [
                SizedBox(
                  height: height*0.7,
                  child: PageView.builder(

                    itemCount: onBoardingList.onBoardingList.length,
                    controller: _pageController,
                    itemBuilder: (context, index) {
                      return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end, children: [
                            Image.asset(onBoardingList.onBoardingList[index].imageUrl,),
                            Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                              child: Text(onBoardingList.onBoardingList[index].title, style: titilliumBold.copyWith(fontSize: 18), textAlign: TextAlign.center),),
                            Text(onBoardingList.onBoardingList[index].description, textAlign: TextAlign.center, style: titilliumRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault)),
                            const SizedBox(height: Dimensions.paddingSizeDefault),
                          ],
                        ),
                      );
                    },
                    onPageChanged: (index) {
                      onBoardingList.changeSelectIndex(index);
                    },
                  ),
                ),


                Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
                  child: Stack(children: [
                    if(onBoardingList.onBoardingList.isNotEmpty)
                    Center(child: SizedBox(height: 50, width: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor.withOpacity(.6)),
                          value: (onBoardingList.selectedIndex + 1) / onBoardingList.onBoardingList.length,
                          backgroundColor: Theme.of(context).primaryColor.withOpacity(.125),
                        ),
                      ),
                    ),
                    Align(alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          if (onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1) {
                            Provider.of<SplashProvider>(context, listen: false).disableIntro();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
                          } else {
                            _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(shape: BoxShape.circle,),
                          child: Icon(onBoardingList.selectedIndex == onBoardingList.onBoardingList.length - 1 ? Icons.check : Icons.navigate_next,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),

          Positioned(child: Align(alignment: Alignment.topRight, child: InkWell(
            onTap: (){
              Provider.of<SplashProvider>(context, listen: false).disableIntro();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Text('${getTranslated('skip', context)}', style: textMedium.copyWith(color: Theme.of(context).primaryColor)),
            ),
          )))
        ],
      ),
    );
  }

}
