import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/theming/styles.dart';

import '../../../../core/routing/routs.dart';

Widget alreadyHaveAccountText(BuildContext context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Already have an account?",
          style: AppTextStyles.font14GreyDarkRegular,
        ),
        TextSpan(
          text: " Sign in",
          style: AppTextStyles.font14BlueBold,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              context.pushReplacementNamed(Routes.loginScreen);
            },),
      ],
    ),
  );
}
