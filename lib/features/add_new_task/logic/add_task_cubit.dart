import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:taski/core/helpers/extentions.dart';
import 'package:taski/features/add_new_task/models/add_task_model.dart';
import 'package:taski/features/add_new_task/models/upload_image_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/helpers/constants.dart';
import '../../../core/helpers/secured_storage_helper.dart';
import '../../../core/helpers/sharedprefrences_helper.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_helper.dart';
part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  static AddTaskCubit get(context) => BlocProvider.of(context);


  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

List<String> galleryOrCam= ["From Gallery","From Cam"];
List<String> priorityList= ["low ", "medium" , "high"];

  AddTaskModel addTaskModel =AddTaskModel();
  Future<String?> accessToken = SecureStorageHelper.getData(key: SecureStorageKeys.accessToken);




void selectPriority(int index,BuildContext context){
  priorityController.text = priorityList[index];
  context.pop();
  emit(SelectPrioritySuccess());
}


void selectImageSource(int index,BuildContext context){
  if(index==0){
    pickImage(ImageSource.gallery);
    context.pop();
  }else{
    pickImage(ImageSource.camera);
    context.pop();
  }
  emit(SelectImageSource());
}
void removeAllSavedData(){
  selectedImage = null;
  dateController.clear();
  titleController.clear();
  descriptionController.clear();
  priorityController.clear();
  emit(RemoveAllSavedData());
}

void deletePickedImage(){
  selectedImage = null;
  emit(PickedImageDeleted());
}


  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  // Function to pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    emit(PicImageLoading());
    final XFile? pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 100, // Optional: Compresses image quality (0-100)
    );
    if (pickedFile != null) {
      emit(PicImageSuccess());
         selectedImage = File(pickedFile.path);
    }
  }


  Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000), // Earliest allowable date
  lastDate: DateTime(2100),  // Latest allcowable date
  );

  if (picked != null) {
  // Format the date using the intl package (e.g., 2026-06-19)
  dateController.text = DateFormat('yyyy-MM-dd').format(picked);

  }
}

  Future<void> addNewTaskTexts({required BuildContext context}) async {
    emit(AddTaskTextsLoading());
      final String textTitle = titleController.text.trim();
      final String textDesc = descriptionController.text.trim();
      final String textPriority = priorityController.text.trim();
      final String textDueDate = dateController.text.trim();
        await DioHelper.postData(
          url: ApiConstants.addTaskUrl,
          data:{
            'title': textTitle,
            'desc': textDesc,
            'priority': textPriority,
            'dueDate': textDueDate,
            'image':  uploadImageModel.image.toString(),

          },
          token: await accessToken,
        ).then((value) async{
          if (value.statusCode == 201 || value.statusCode == 200) {
            addTaskModel = AddTaskModel.fromJson(value.data);
            debugPrint("${addTaskModel.sId.toString().toUpperCase()} ==++ SUCCESS");
            emit(AddTaskTextsSuccess());
            removeAllSavedData();
          }
        }).catchError((e) {
          emit(AddTaskTextsFail());
          debugPrint("${e.toString()} ==++ ERROR");
          if(e.response?.data !=null){
            debugPrint("${e.response?.data}");
          }
        });



  }

 UploadImageModel uploadImageModel = UploadImageModel();

  Future<void> addNewTask({required BuildContext context}) async {
    emit(AddTaskWithImageLoading());
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last),
    });
    await DioHelper.postImageData(
      url: ApiConstants.uploadImageUrl,
      data:data,
      token:await accessToken,
    ).then((value) async{
      if (value.statusCode == 201 || value.statusCode == 200) {
        uploadImageModel = UploadImageModel.fromJson(value.data);
        debugPrint("${uploadImageModel.image} ==++Upload Image SUCCESS");
       await addNewTaskTexts(context: context);
        emit(AddTaskWithImageSuccess());
      }
    }).catchError((e) {
      emit(AddTaskWithImageFail());
      debugPrint("${e.toString()} ==++ Upload Image ERROR");
      if(e.response?.data !=null){
        debugPrint("${e.response?.data}");
      }
    });
  }














}
