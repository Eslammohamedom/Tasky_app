import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/profile/ui/widgets/profile_app_bar.dart';
import 'package:taski/features/profile/ui/widgets/profile_data_item.dart';

import '../logic/profile_cubit.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(context: context),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
              body: SafeArea(
                child: state is !ProfileLoading?
                  Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 24.w, vertical: 16.h),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(children: [
                        profileAppBar(context),
                        SizedBox(height: 24.h,),
                        profileDataItem(isPhone: false,cubit: cubit,hintText: "Name",text:cubit.profileModel.displayName.toString() ),
                        profileDataItem(isPhone: true,cubit: cubit,hintText: "PHONE",text:cubit.profileModel.username.toString()),
                        profileDataItem(isPhone: false,cubit: cubit,hintText: "LEVEL",text:cubit.profileModel.level.toString()),
                        profileDataItem(isPhone: false,cubit: cubit,hintText: "Years of experience",text:cubit.profileModel.experienceYears.toString()),
                        profileDataItem(isPhone: false,cubit: cubit,hintText: "LOCATION",text:cubit.profileModel.address.toString()),


                      ],)),
                ):SizedBox.shrink(),
              )
          );
        },
      ),
    );
  }
}
