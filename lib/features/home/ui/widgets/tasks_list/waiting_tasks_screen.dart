import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/features/home/ui/widgets/status_list/task_status_list.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../logic/home_cubit.dart';
import 'tasks_list_item.dart';

class WaitingTasksScreen extends StatelessWidget {
  const WaitingTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.waitingTasks.isNotEmpty
            ?ListView.builder(
          shrinkWrap: true,
          itemCount: cubit.waitingTasks.length,
          physics:const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return myTasksListItem(context, cubit.waitingTasks, index,cubit,state);
          },

        )
        : Center(child: Text("NO WAITING TASKS ",style: AppTextStyles.font19MainBlueMedium,));
      },
    );
  }
}


