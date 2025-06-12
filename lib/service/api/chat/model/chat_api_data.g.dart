// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequestMessage _$RequestMessageFromJson(Map<String, dynamic> json) =>
    _RequestMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$RequestMessageToJson(_RequestMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

_RequestBody _$RequestBodyFromJson(Map<String, dynamic> json) => _RequestBody(
  model: json['model'] as String,
  messages:
      (json['messages'] as List<dynamic>)
          .map((e) => RequestMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$RequestBodyToJson(_RequestBody instance) =>
    <String, dynamic>{'model': instance.model, 'messages': instance.messages};

_ResponseMessage _$ResponseMessageFromJson(Map<String, dynamic> json) =>
    _ResponseMessage(
      role: json['role'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$ResponseMessageToJson(_ResponseMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};

_Choice _$ChoiceFromJson(Map<String, dynamic> json) => _Choice(
  finishReason: json['finish_reason'] as String,
  index: (json['index'] as num).toInt(),
  message: ResponseMessage.fromJson(json['message'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ChoiceToJson(_Choice instance) => <String, dynamic>{
  'finish_reason': instance.finishReason,
  'index': instance.index,
  'message': instance.message,
};

_ChatCompletion _$ChatCompletionFromJson(Map<String, dynamic> json) =>
    _ChatCompletion(
      id: json['id'] as String,
      created: (json['created'] as num).toInt(),
      model: json['model'] as String,
      objectValue: json['object'] as String,
      choices:
          (json['choices'] as List<dynamic>)
              .map((e) => Choice.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ChatCompletionToJson(_ChatCompletion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'model': instance.model,
      'object': instance.objectValue,
      'choices': instance.choices,
    };
