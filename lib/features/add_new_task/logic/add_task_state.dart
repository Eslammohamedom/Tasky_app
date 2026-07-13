part of 'add_task_cubit.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}
final class PicImageLoading extends AddTaskState {}
final class PicImageSuccess extends AddTaskState {}
final class PickedImageDeleted extends AddTaskState {}
final class  AddTaskTextsSuccess extends AddTaskState {}
final class  AddTaskTextsFail extends AddTaskState {}
final class  AddTaskTextsLoading extends AddTaskState {}
final class  SelectImageSource extends AddTaskState {}
final class  SelectPrioritySuccess extends AddTaskState {}
final class  RemoveAllSavedData extends AddTaskState {}
final class  AddTaskWithImageLoading extends AddTaskState {}
final class  AddTaskWithImageSuccess extends AddTaskState {}
final class  AddTaskWithImageFail extends AddTaskState {}