import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/styles.dart';

Widget appPhoneTextField(
    {required TextEditingController controller,bool disableLengthCheck = true,
      void Function(String completeNumber)? onPhoneChanged,

      })
    {
  return IntlPhoneField(
    dropdownIconPosition:IconPosition.trailing,
    dropdownIcon: Icon(Icons.keyboard_arrow_down_rounded,color: AppColorsManager.greyDark,size: 24.sp,),
    controller: controller,
    languageCode: 'ar',
    disableLengthCheck:disableLengthCheck,
    validator: (value) {
      if (value == null || value.number.isEmpty) {
        return 'Please enter a valid phone number';
      }
      return null;
    },
    decoration:  InputDecoration(
      hintText: "1234567_890",
      filled: true,
      fillColor:  Colors.transparent,
      isDense: true,
      hintStyle:  AppTextStyles.font14GreyDarkRegular,
      contentPadding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 12.h),
      focusedBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsManager.mainBlue,
              width: 1),
          borderRadius: BorderRadius.circular(10)
      ) ,
      enabledBorder:  OutlineInputBorder(
          borderSide: const BorderSide(color: AppColorsManager.grey,
              width: 1),
          borderRadius: BorderRadius.circular(10)
      ) ,
      border: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColorsManager.grey,
                width: 1),
            borderRadius: BorderRadius.circular(10.r)
        )

    ),
    initialCountryCode: 'EG', // Set your default country selection
    onChanged: (phone) {
      if (onPhoneChanged != null) {
        onPhoneChanged(phone.completeNumber);
      }

      debugPrint('Country changed to: ${phone}');
    },
    onCountryChanged: (country) {
      debugPrint('Country changed to: ${country.name}');
      debugPrint('Country changed to: ${country.code}');
      debugPrint('Country changed to: +${country.dialCode}');
    },
  );

}