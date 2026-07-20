import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/core/routing/routs.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../../../core/theming/colors.dart';
import '../models/all_tasks_model.dart';
import '../ui/widgets/tasks_list/all_tasks_screen.dart';
import '../ui/widgets/tasks_list/finished_tasks.dart';
import '../ui/widgets/tasks_list/inprogress_tasks_screen.dart';
import '../ui/widgets/tasks_list/waiting_tasks_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
static HomeCubit get(context)=>BlocProvider.of(context);





late List<List<Data>> allTasksByStatus = [allTasks,inProgressTasks,waitingTasks,finishedTasks];

  List<String> tasksStatus=["All","InProgress","Waiting","Finished"];
  int currentStatusIndex = 0;
  void setCurrentStatusIndex(index){
    currentStatusIndex = index;
    emit(SetCurrentStatusIndexState());
  }


List<Widget> screens = [AllTasksScreen(),InProgressTasksScreen(),WaitingTasksScreen(),FinishedTasksScreen()];
  int pageNum = 1;
  Future<String?> accessToken = SecureStorageHelper.getData(key: SecureStorageKeys.accessToken);
  List<Data> finishedTasks = [];
  List<Data> waitingTasks = [];
  List<Data> inProgressTasks = [];
  List<Data> allTasks = [];
  AllTasksModel allTasksModel = AllTasksModel();
bool hasMoreData = true;


  Future<void> getAllTasksData({required BuildContext context}) async {
    emit(HomeLoading());
    await DioHelper.getData(url: "${ApiConstants.getAllTasksUrl}${pageNum}",token:await accessToken).then((value) async{
      if (value.statusCode == 200){
      allTasksModel = AllTasksModel.fromJson(value.data);
       hasMoreData = allTasksModel.data!.isNotEmpty&&allTasksModel.data!.length>=20;
       debugPrint("HASMORE===>${hasMoreData}>>================= ==++ SUCCESSsssssssssssssssss");
       debugPrint("pageNum===>${pageNum}>>================= ==++ SUCCESSsssssssssssssssss");
        if (allTasksModel.data!.isNotEmpty){
          pageNum++ ;
          allTasks.addAll(allTasksModel.data!);
          finishedTasks = allTasks.where((task) => task.status == 'finished').toList();
          waitingTasks = allTasks.where((task) => task.status == 'waiting').toList();
          inProgressTasks = allTasks.where((task) => task.status == 'inprogress').toList();

          debugPrint("LENGTH=${allTasks.length}================= ==++ SUCCESSsssssssssssssssss");
          debugPrint(" PAGE NUM ========----${pageNum}---================== ==++ SUCCESSsssssssssssssssss");
          debugPrint("${finishedTasks.length}================== ==++ SUCCESSsssssssssssssssss");
          debugPrint("${waitingTasks.length}================== ==++ SUCCESSsssssssssssssssss");
          debugPrint("${inProgressTasks.length}================== ==++ SUCCESSsssssssssssssssss");
        }

        emit(HomeSuccess());
      }
    }).catchError((e)async{
      emit(HomeFail());
      debugPrint("${e.toString()} ==++ ERROR");
    });
  }

Future<void> clearTasksListAndGetTasksData(BuildContext context)async{
    allTasks.clear();
    finishedTasks.clear();
    waitingTasks.clear();
    inProgressTasks.clear();
    pageNum = 1;
   await getAllTasksData(context: context);
    emit(ClearTasksListAndGetTasksDataState());
  }







  Color setStatusTextColor (String status){
    switch (status.toLowerCase()) {
      case 'finished':
        return AppColorsManager.burble;
      case 'waiting':
        return AppColorsManager.orange;
      case 'inprogress':
        return AppColorsManager.mainBlue;
      default:
        return AppColorsManager.mainBlue; // Default/fallback color
    }
  }

  Color setStatusBackGroundColor (String status){
    switch (status.toLowerCase()){
      case 'finished':
        return AppColorsManager.lightBurble;
      case 'waiting':
        return AppColorsManager.lightOrange;
      case 'inprogress':
        return AppColorsManager.lightBlue;
      default:
        return AppColorsManager.mainBlue; // Default/fallback color
    }
  }

  Color setPriorityTextColor (String priority){
    switch (priority.toLowerCase()) {
    case 'low':
    return AppColorsManager.burble;
    case 'high':
    return AppColorsManager.orange;
    case 'medium':
    return AppColorsManager.mainBlue;
    default:
    return AppColorsManager.mainBlue; // Default/fallback color
    }// Default/fallback color
    }



  Future<void> userLogOut({required BuildContext context}) async {
    emit(LogOutLoading());
    await DioHelper.postData(url: ApiConstants.logoutUrl, data: {
      'token': accessToken.toString().trim(),
    }).then((value) async{
      if (value.statusCode == 201){
        await SecureStorageHelper.removeData(key: SecureStorageKeys.accessToken);
        await SecureStorageHelper.removeData(key: SecureStorageKeys.refreshToken);
        context.pushNamed(Routes.loginScreen);
        emit(LogOutSuccess());
      }

    }).catchError((e){
      emit(LogOutFail());
      print("${e.toString()} ==++ ERROR");

    });
  }






  Future<void> deleteTask({required BuildContext context,required String id}) async {
    emit(DeleteTaskLoading());
    await DioHelper.deleteData(url: ApiConstants.deleteTaskUrl+id,token:await accessToken
    ).then((value) async{
      if (value.statusCode == 200){
        allTasks.removeWhere((item) => item.sId == id);
        finishedTasks.removeWhere((item) => item.sId == id);
        inProgressTasks.removeWhere((item) => item.sId == id);
        waitingTasks.removeWhere((item) => item.sId == id);

        emit(DeleteTaskSuccess());
      }

    }).catchError((e){
      emit(DeleteTaskFail());

      print("${e.toString()} ==++ ERROR");

    });
  }






}








