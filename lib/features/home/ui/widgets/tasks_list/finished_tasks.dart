import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/features/home/ui/widgets/status_list/task_status_list.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../logic/home_cubit.dart';
import 'tasks_list_item.dart';

class FinishedTasksScreen extends StatelessWidget {
  const FinishedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.finishedTasks.isNotEmpty?ListView.builder(
          shrinkWrap: true,
        itemCount: cubit.finishedTasks.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
             return myTasksListItem(context, cubit.finishedTasks, index,cubit,state);
          },

        ): state is HomeLoading ?Center(child:CupertinoActivityIndicator()): Center(child: Text("No Finished Tasks",style: AppTextStyles.font19MainBlueMedium,));
      },
    );
  }
}


