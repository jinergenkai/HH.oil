import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';
part 'record_line.freezed.dart';


@freezed
class RecordLine with _$RecordLine {
  const factory RecordLine({
    @Default(0) int id,
    @Default(0) int index,
    @Default('') String content,
    // @Default(DateTime) String createdAt,
    @Default(BigDecimal.zero) BigDecimal money,
  }) = _RecordLine;
}
