import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taski/core/helpers/spacing.dart';
import 'package:taski/core/widgets/app_text_button.dart';
import 'package:taski/features/add_new_task/logic/add_task_cubit.dart';
import 'package:taski/features/add_new_task/ui/widgets/add_image_pattern.dart';
import 'package:taski/features/add_new_task/ui/widgets/add_task_appbar.dart';
import 'package:taski/features/add_new_task/ui/widgets/task_priority_and_date.dart';
import 'package:taski/features/add_new_task/ui/widgets/task_title_and_discribtion.dart';
import '../../../core/theming/styles.dart';



class AddNewTaskScreen extends StatelessWidget {
  const AddNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: BlocConsumer<AddTaskCubit, AddTaskState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AddTaskCubit.get(context);
          var formKey = GlobalKey<FormState>();
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 24.w,
                    ),
                    child: Column(
                      children: [
                        addNNewTaskAppBar(context),
                        verticalSpace(36),
                        addImage(context,cubit),
                        verticalSpace(16),
                        taskTitleAndDescription(
                          taskTitleController: cubit.titleController,
                          taskDescriptionController: cubit.descriptionController,
                        ),
                        verticalSpace(16),
                        addTaskPriorityItem(
                          controller: cubit.priorityController,
                          hintText: '', cubit: cubit, context: context,

                        ),
                        verticalSpace(16),
                        addTaskDateItem(
                          controller: cubit.dateController,
                          cubit:cubit,
                          context: context,
                          hintText: '',
                        ),
                        verticalSpace(24),
                       state is AddTaskTextsLoading||state is AddTaskWithImageLoading? const Center(child: CupertinoActivityIndicator()): AppTextButton(buttonText: "Add task", textStyle: AppTextStyles.font19WhiteBold,

                            onPressed: (){
                          if(formKey.currentState!.validate()&&cubit.selectedImage!=null){

                         cubit.addNewTask(context: context);}
                            })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
