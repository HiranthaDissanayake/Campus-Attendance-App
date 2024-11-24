import 'package:attendenz/constants/colors.dart';
import 'package:attendenz/data/onboarding_data.dart';
import 'package:attendenz/screens/Onboarding/FrontPage.dart';
import 'package:attendenz/screens/Onboarding/shared_onboarding_pages.dart';
import 'package:attendenz/screens/user_data_screen.dart';
import 'package:attendenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  //page controller
 final PageController _controller = PageController();
 bool showDetailsPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
            
                //Onbording Screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailsPage = index == 2;

                    });
                  },

                  children: [
                    const Frontpage(),
                    
                    SharedOnboardingPages(
                      title: OnboardingData.onboardingDataList[0].title,
                      imagePath: OnboardingData.onboardingDataList[0].imagePath,
                      description: OnboardingData.onboardingDataList[0].description
                      ),

                    SharedOnboardingPages(
                      title: OnboardingData.onboardingDataList[1].title,
                      imagePath: OnboardingData.onboardingDataList[1].imagePath,
                      description: OnboardingData.onboardingDataList[1].description
                      ),
                  ],
                ),

                // page dot indicator

                Container(
                  alignment: const Alignment(0, 0.5),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      activeDotColor: MainColor,
                      dotColor: Color.fromARGB(255, 212, 208, 208)
                    ),
                    )
                ),

                // navigation button
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                  child: !showDetailsPage ? GestureDetector (
                      onTap: (){
                        _controller.animateToPage(
                          _controller.page!.toInt() + 1,
                          duration:const Duration(milliseconds: 400),
                          curve: Curves.decelerate
                        );
                      },
                      child:CustomButton(
                        buttonName: showDetailsPage ?  "Get Started" : "Next",
                        buttonColor: MainColor,
                        ),
                    ) : GestureDetector (
                      onTap: (){
                        // Navigate to the user data screen
                        Navigator.push(context,
                        MaterialPageRoute(builder: 
                        (context) => const UserDataScreen()
                        )
                        );
                      },
                      child:CustomButton(
                        buttonName: showDetailsPage ?  "Get Started" : "Next",
                        buttonColor: MainColor,
                        ),
                    ),
                  )
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}