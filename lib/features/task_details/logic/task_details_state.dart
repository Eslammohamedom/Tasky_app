part of 'task_details_cubit.dart';

@immutable
sealed class TaskDetailsState {}

final class TaskDetailsInitial extends TaskDetailsState {}
final class TaskDetailsSuccess extends TaskDetailsState {}
final class TaskDetailsFail extends TaskDetailsState {}
final class TaskDetailsLoading extends TaskDetailsState {}
final class SelectDateSuccess extends TaskDetailsState {}
final class SelectPrioritySuccess extends TaskDetailsState {}
final class SelectStatusSuccess extends TaskDetailsState {}
final class DeleteTaskLoadingState extends TaskDetailsState {}
final class DeleteTaskSuccess extends TaskDetailsState {}
final class DeleteTaskFail extends TaskDetailsState {}
final class GetTaskLoading extends TaskDetailsState {}
final class GetTaskSuccess extends TaskDetailsState {}
final class GetTaskFail extends TaskDetailsState {}
final class UpdateTaskLoading extends TaskDetailsState {}
final class UpdateTaskSuccess extends TaskDetailsState {}
final class UpdateTaskFail extends TaskDetailsState {}
final class SaveControllersDataSuccess extends TaskDetailsState {}
final class PicImageLoading extends TaskDetailsState {}
final class PicImageSuccess extends TaskDetailsState {}
final class PicImageFail extends TaskDetailsState {}
final class PickedImageDeleted extends TaskDetailsState {}

