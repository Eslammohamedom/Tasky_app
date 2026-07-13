import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/features/home/ui/widgets/barcode_and_add_icon.dart';
import 'package:taski/features/home/ui/widgets/app_par/home_app_bar.dart';
import 'package:taski/features/home/ui/widgets/home_shimmer_effict.dart';
import 'package:taski/features/home/ui/widgets/status_list/task_status_list.dart';
import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../logic/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllTasksData(context: context),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
              body: SafeArea(
                child: RefreshIndicator(
                  onRefresh: ()async{
                   await cubit.clearTasksListAndGetTasksData(context);
                  },
                  child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 24.w),
                      child:  NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {//(notification.metrics.axis == Axis.vertical
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent  && scrollInfo.metrics.axis == Axis.vertical ) {

                            if (scrollInfo is ScrollEndNotification&&cubit.hasMoreData) {
                             cubit.getAllTasksData(context: context);
                            }
                          }
                          return false;
                        },
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                homeAppBar(context, state,cubit),
                                verticalSpace(24),
                                Text("My Tasks", style: AppTextStyles.font16DarkGreyBold),
                                verticalSpace(16),
                                taskStatusList(cubit),
                                verticalSpace(16),
                                Expanded(child: cubit.screens[cubit.currentStatusIndex]),
                                state is HomeLoading&&cubit.allTasks.isNotEmpty
                                    ? Center(child: CupertinoActivityIndicator())
                                    : SizedBox.shrink(),

                              ],
                            ),
                            barcodeAndAddIcons(context,cubit),
                          ],
                        ),
                      )),
                ),
              ));
        },
      ),
    );
  }
}
//home
