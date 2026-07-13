import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/features/home/ui/widgets/status_list/task_status_list.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/styles.dart';
import '../../../logic/home_cubit.dart';
import 'tasks_list_item.dart';

class InProgressTasksScreen extends StatelessWidget {
  const InProgressTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return cubit.inProgressTasks.isNotEmpty?ListView.builder(
          shrinkWrap: true,
          itemCount: cubit.inProgressTasks.length,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return myTasksListItem(context, cubit.inProgressTasks, index,cubit,state);
          },

        ): Center(child: Text("No INPROGRESS Tasks",style: AppTextStyles.font19MainBlueMedium,));
      },
    );
  }
}


