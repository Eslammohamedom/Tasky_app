import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/theming/styles.dart';

import '../../../../core/routing/routs.dart';

Widget doNotHaveAccountText(BuildContext context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Don’t have any account?",
          style: AppTextStyles.font14GreyDarkRegular,
        ),
        TextSpan(
          text: " Sign Up here",
          style: AppTextStyles.font14BlueBold,
          recognizer: TapGestureRecognizer()
          ..onTap = () {
            context.pushReplacementNamed(Routes.signUpScreen);
          },),
      ],
    ),
  );
}
