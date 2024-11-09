part of 'app_cubit_cubit.dart';

@immutable
sealed class AppCubitState {}

final class AppCubitInitial extends AppCubitState {}

final class GetChatIdSuccessfully extends AppCubitState {}

final class GetChatIdError extends AppCubitState {}


final class SendMessageSuccessfully extends AppCubitState {}
final class SendMessageWithError extends AppCubitState {}

final class GetGeminiResponseLoading extends AppCubitState {}
final class GetGeminiResponseSuccessfully extends AppCubitState {}
final class GetGeminiResponseError extends AppCubitState {}
final class GetAllMessagesSuccessfully extends AppCubitState {}
final class GetAllMessagesLoading extends AppCubitState {}

