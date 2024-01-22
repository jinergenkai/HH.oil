import 'dart:async';

import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'home_event.freezed.dart';

abstract class HomeEvent extends BaseBlocEvent {
  const HomeEvent();
}

@freezed
class HomePageInitiated extends HomeEvent with _$HomePageInitiated {
  const factory HomePageInitiated() = _HomePageInitiated;
}

@freezed
class HomePageRefreshed extends HomeEvent with _$HomePageRefreshed {
  const factory HomePageRefreshed({
    required Completer<void> completer,
  }) = _HomePageRefreshed;
}

@freezed
class UserLoadMore extends HomeEvent with _$UserLoadMore {
  const factory UserLoadMore() = _UserLoadMore;
}

@freezed
class AddRecordLine extends HomeEvent with _$AddRecordLine {
  const factory AddRecordLine({
    required RecordLine recordLine,
  }) = _AddRecordLine;
}

@freezed
class UpdateRecordLine extends HomeEvent with _$UpdateRecordLine {
  const factory UpdateRecordLine({
    required RecordLine recordLine,
  }) = _UpdateRecordLine;
}

@freezed
class DeleteRecordLine extends HomeEvent with _$DeleteRecordLine {
  const factory DeleteRecordLine({
    required RecordLine recordLine,
  }) = _DeleteRecordLine;
}