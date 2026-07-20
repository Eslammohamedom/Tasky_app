import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/features/home/logic/home_cubit.dart';
import '../../../../../core/theming/styles.dart';
import 'tasks_list_item.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return cubit.allTasks.isNotEmpty
            ?ListView.builder(
          shrinkWrap: true,
          itemCount: cubit.allTasks.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return myTasksListItem(context, cubit.allTasks, index,cubit,state);
          },

        )
            :state is HomeLoading ?Center(child:CupertinoActivityIndicator()):Center(child: Text("No Tasks",style: AppTextStyles.font19MainBlueMedium,));
        ;
      },
    );
  }
}

