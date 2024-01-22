import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
part 'record_line.freezed.dart';


@freezed
class RecordLine with _$RecordLine {
  const factory RecordLine({
    @Default(0) int id,
    @Default(0) int index,
    @Default('') String content,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(0) num money,
    @Default(1) num sign,
  }) = _RecordLine;
}
