part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeSuccess extends HomeState {}
final class HomeFail extends HomeState {}
final class LogOutSuccess extends HomeState {}
final class LogOutFail extends HomeState {}
final class LogOutLoading extends HomeState {}

final class DeleteTaskSuccess extends HomeState {}
final class DeleteTaskFail extends HomeState {}
final class DeleteTaskLoading extends HomeState {}


final class SetCurrentStatusIndexState extends HomeState {}
final class SetScrollControllerState extends HomeState {}
final class ClearTasksListAndGetTasksDataState extends HomeState {}
