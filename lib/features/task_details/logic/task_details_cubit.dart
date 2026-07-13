import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:taski/features/task_details/models/one_task_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/extentions.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/helpers/sharedprefrences_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
import '../models/upload_image_model.dart';

part 'task_details_state.dart';

class TaskDetailsCubit extends Cubit<TaskDetailsState> {
  TaskDetailsCubit() : super(TaskDetailsInitial());
  static TaskDetailsCubit get(context) => BlocProvider.of(context);
  final TextEditingController dateController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  String date = '';
  Future<String?>  accessToken = SecureStorageHelper.getData(key: SecureStorageKeys.accessToken);
  UploadImageModel uploadImageModel = UploadImageModel();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null){
      date = DateFormat('yyyy-MM-dd').format(picked);
      dateController.text = date;
      print("Selected date: ${picked.toLocal()}");
      emit(SelectDateSuccess());
    }

  }


  List<String> priorityList=['low','medium','high'];

  void  selectPriority(int index,BuildContext context){
    priorityController.text = priorityList[index];
    context.pop();
    emit(SelectPrioritySuccess());
  }



  List<String> statusList=['inprogress','waiting','finished'];

  void  selectStatus(int index,BuildContext context){
    statusController.text = statusList[index];
    context.pop();
    emit(SelectPrioritySuccess());
  }

  Future<void> deleteTask({required BuildContext context,required String id}) async {
    emit(DeleteTaskLoadingState());
    await DioHelper.deleteData(url: ApiConstants.deleteTaskUrl+id,
      token:await accessToken,
    ).then((value) async{
      if (value.statusCode == 200){
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: "   تم الحزف    ")
        );
        emit(DeleteTaskSuccess());
      }

    }).catchError((e){
      emit(DeleteTaskFail());

      print("${e.toString()} ==++ ERROR");

    });
  }


OneTaskModel oneTaskModel = OneTaskModel();

  Future<void> getTask({required BuildContext context,required String id}) async {
    emit(GetTaskLoading());
    await DioHelper.getData(url: "${ApiConstants.getOneTaskUrl}${id}",
      token: await accessToken,
    ).then((value) async{
      if (value.statusCode == 200){
        print((value.data).toString());
       oneTaskModel = OneTaskModel.fromJson(value.data);
        saveControllersData();
        emit(GetTaskSuccess());
      }
    }).catchError((e){
      emit(GetTaskFail());

      print("${e.toString()} ==++ ERROR");

    });
  }




void saveControllersData(){
  DateTime parsedDate = DateTime.parse(oneTaskModel.createdAt.toString());
    dateController.text = DateFormat('yyyy-MM-dd').format(parsedDate).toString();
    priorityController.text = oneTaskModel.priority.toString();
    statusController.text = oneTaskModel.status.toString();
    descriptionController.text = oneTaskModel.desc.toString();
    titleController.text = oneTaskModel.title.toString();
    emit(SaveControllersDataSuccess());
}


  Future<void> editTask({required BuildContext context,required String id}) async {
    emit(UpdateTaskLoading());
   FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last),});
    await DioHelper.postImageData(
      url: ApiConstants.uploadImageUrl,
      data:data,
      token:await accessToken,
    ).then((value) async{
      if (value.statusCode == 201 || value.statusCode == 200) {
        uploadImageModel = UploadImageModel.fromJson(value.data);
        debugPrint("${uploadImageModel.image} ==++Upload Image SUCCESS");
        await editTaskTexts(context: context,id:id,image: uploadImageModel.image.toString());
        emit(UpdateTaskSuccess());
      }
    }).catchError((e) {
      emit(UpdateTaskFail());
      debugPrint("${e.toString()} ==++ Upload Image ERROR");
      if(e.response?.data !=null){
        debugPrint("${e.response?.data}");
      }
    });

  }


  Future<void> editTaskTexts({required BuildContext context,required String id,required String image}) async {
    emit(UpdateTaskLoading());
    await DioHelper.putData(
        url: ApiConstants.getOneTaskUrl+id,
        token: await accessToken,
        data: {
          'title': titleController.text.trim(),
          'desc': descriptionController.text.trim(),
          'priority': priorityController.text.trim(),
          'status': statusController.text.trim(),
          'dueDate': dateController.text.trim(),
          if (selectedImage != null) 'image': image
        }
    ).then((value) async{
      if (value.statusCode == 200){
        showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(message: "   تم التعديل    ")
        );
        emit(UpdateTaskSuccess());
      }
    }).catchError((e){
      emit(UpdateTaskFail());

      print("${e.toString()} ==++ ERROR");

    });
  }

void clearSelectedImage(){
    selectedImage = null;
    emit(PickedImageDeleted());
}


  File? selectedImage;
  final ImagePicker picker = ImagePicker();


  Future<void> pickImage(ImageSource source) async {
    emit(PicImageLoading());
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      emit(PicImageSuccess());
      selectedImage = File(pickedFile.path);
    }
  }



}
