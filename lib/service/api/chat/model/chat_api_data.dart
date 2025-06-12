
// 用于定于接口传输数据规范
import 'package:freezed_annotation/freezed_annotation.dart' ;

part 'chat_api_data.freezed.dart';
part 'chat_api_data.g.dart';

@freezed
abstract  class RequestMessage with _$RequestMessage {
  const factory RequestMessage({
    required String role,
    required String content,
  }) = _RequestMessage;

  factory RequestMessage.fromJson(Map<String, dynamic> json) =>
      _$RequestMessageFromJson(json);
}

// 请求对话消息补全的主体
@freezed
abstract  class RequestBody with _$RequestBody {
  const factory RequestBody({
    required String model,
    required List<RequestMessage> messages,
  }) = _RequestBody;

  factory RequestBody.fromJson(Map<String, dynamic> json) =>  
      _$RequestBodyFromJson(json);
}



@freezed
abstract  class ResponseMessage with _$ResponseMessage {
  const factory ResponseMessage({
    required String role,
    required String content,
  }) = _ResponseMessage;

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ResponseMessageFromJson(json);
}

@freezed
abstract class Choice with _$Choice {
  const factory Choice({
    @JsonKey(name: 'finish_reason') 
    required String finishReason,
    required int index,
    required ResponseMessage message,
  }) = _Choice;

  factory Choice.fromJson(Map<String, dynamic> json) =>
      _$ChoiceFromJson(json);
}

// 返回结果的主体

@freezed
abstract class ChatCompletion with _$ChatCompletion {
  const factory ChatCompletion({
    required String id,
    required int created,
    required String model,
    @JsonKey(name: 'object') 
    required String objectValue,
    required List<Choice> choices,
  }) = _ChatCompletion;

  factory ChatCompletion.fromJson(Map<String, dynamic> json) =>
      _$ChatCompletionFromJson(json);
}


