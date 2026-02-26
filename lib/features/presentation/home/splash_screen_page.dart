// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../data/splash_data.dart';
import 'package:one_profile/services/app_preferences.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/common/app_font.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: const EdgeInsets.only(right: 5),
                            height: 6,
                            width: currentPage == index ? 20 : 6,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? AppColors.primary_blue
                                  : const Color(0xFFD8D8D8),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                      ElevatedButton(
                        onPressed: () async {
                          await AppPreferences.setOnboardingCompleted();
                          if (context.mounted) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home',
                              (route) => false,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: AppColors.primary_blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(300, 48),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        child: Text("ข้าม", style: AppFont.promptBodyLarge),
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({Key? key, this.text, this.image}) : super(key: key);
  final String? text, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Text(
          "One Profile",
          style: TextStyle(
            fontSize: 32,
            color: AppColors.primary_blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(widget.text!, textAlign: TextAlign.center),
        const Spacer(flex: 2),
        Image.asset(
          widget.image!,
          fit: BoxFit.contain,
          height: 265,
          width: 235,
        ),
      ],
    );
  }
}
