

import 'package:freezed_annotation/freezed_annotation.dart' ;

part 'token_info.freezed.dart';
part 'token_info.g.dart';

@freezed
abstract  class TokenInfo with _$TokenInfo {
  const factory TokenInfo({
    required String value,
    required int expiredAt, // 传时间戳
  }) = _TokenInfo;

  factory TokenInfo.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoFromJson(json);
}
