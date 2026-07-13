import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';


class AppTextFormField extends StatelessWidget {
  final EdgeInsets? contentPadding;
  final TextEditingController? controller;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final TextStyle? hintStyle;
  final TextStyle? inputTextStyle;
  final bool? obsecureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final Color? fillColor;
  final bool? readOnly;
  final bool? expands;
  final int? maxLines;
  final int? minLines;
  final BoxConstraints? constraints;
  final Function(String?) validator;
 // final Function(String?)? onChanged;
  final TextInputType? keyboardtybe;


  const AppTextFormField({
    super.key,
    this.expands,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.constraints,
   required this.controller,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.readOnly,
     this.hintStyle,
     this.inputTextStyle,
     this.obsecureText,
    this.suffixIcon,
    required this.hintText,
    required this.validator ,
  this.fillColor,
   //required this.onChanged,
    this.keyboardtybe,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      expands: expands ?? false,
      controller: controller,
      maxLines: maxLines ,
      minLines: minLines ,
      readOnly: readOnly ?? false,
      textAlignVertical: TextAlignVertical.top,
      keyboardType:keyboardtybe?? TextInputType.text,
      style: inputTextStyle ?? AppTextStyles.font14BlackMedium,
      obscureText: obsecureText ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        constraints: constraints ?? BoxConstraints(),
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        isDense: true,
        hintStyle: hintStyle ?? AppTextStyles.font14GreyDarkRegular,
        contentPadding: contentPadding  ?? EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
        focusedBorder: focusedBorder ??  OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorsManager.mainBlue,
            width: 1),
        borderRadius: BorderRadius.circular(10.r)
    ) ,
        enabledBorder:  enabledBorder ?? OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorsManager.grey,
            width: 1),
        borderRadius: BorderRadius.circular(10.r)
    ) ,

        border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColorsManager.grey,
            width: 1),
        borderRadius: BorderRadius.circular(10.r)
    ) ,
        suffixIcon: suffixIcon,
        hintText: hintText,

    ),
      validator: (value) {
        return validator(value);
      },

    );
  }
}
