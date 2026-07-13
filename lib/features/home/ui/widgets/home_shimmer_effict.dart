
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/colors.dart';


class ShimmerTaskDatalList extends StatelessWidget {
 const ShimmerTaskDatalList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) =>
          shimmerDataItem(),
    );
  }
}
Widget shimmerDataItem(){
  return Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      children: [
        Shimmer.fromColors(
          baseColor: AppColorsManager.lightGrey,
          highlightColor: Colors.white,
          child: Container(
            height: 110.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColorsManager.moreLighterGrey,
              borderRadius: BorderRadius.circular(10.r),

            ),
          ),
        ),
        horizontalSpace(16),

        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                    baseColor: AppColorsManager.lightGrey,
                    highlightColor: Colors.white,child: Container(
                  height: 14.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: AppColorsManager.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                )),
                verticalSpace(10),
                Shimmer.fromColors(
                    baseColor: AppColorsManager.lightGrey,
                    highlightColor: Colors.white,
                    child:
                    Container(
                      height: 10.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: AppColorsManager.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )),
                verticalSpace(10),
                Shimmer.fromColors(
                    baseColor: AppColorsManager.lightGrey,
                    highlightColor: Colors.white,
                    child:
                    Container(
                      height: 16.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: AppColorsManager.lightGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )),
              ]
          ),
        ),

      ],
    ),
  );
}