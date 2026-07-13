import 'package:flutter/material.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/features/onBoarding/ui/widgets/onboarding_art_text.dart';
import 'package:taski/features/onBoarding/ui/widgets/onboarding_text_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              onboardingArtAndText(),
               verticalSpace(32.5),
              onboardingTextButton(context)



            ],
          )
        ));
  }
}
