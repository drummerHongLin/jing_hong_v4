// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestMessage {

 String get role; String get content;
/// Create a copy of RequestMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestMessageCopyWith<RequestMessage> get copyWith => _$RequestMessageCopyWithImpl<RequestMessage>(this as RequestMessage, _$identity);

  /// Serializes this RequestMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'RequestMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $RequestMessageCopyWith<$Res>  {
  factory $RequestMessageCopyWith(RequestMessage value, $Res Function(RequestMessage) _then) = _$RequestMessageCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$RequestMessageCopyWithImpl<$Res>
    implements $RequestMessageCopyWith<$Res> {
  _$RequestMessageCopyWithImpl(this._self, this._then);

  final RequestMessage _self;
  final $Res Function(RequestMessage) _then;

/// Create a copy of RequestMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RequestMessage implements RequestMessage {
  const _RequestMessage({required this.role, required this.content});
  factory _RequestMessage.fromJson(Map<String, dynamic> json) => _$RequestMessageFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of RequestMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestMessageCopyWith<_RequestMessage> get copyWith => __$RequestMessageCopyWithImpl<_RequestMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'RequestMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$RequestMessageCopyWith<$Res> implements $RequestMessageCopyWith<$Res> {
  factory _$RequestMessageCopyWith(_RequestMessage value, $Res Function(_RequestMessage) _then) = __$RequestMessageCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$RequestMessageCopyWithImpl<$Res>
    implements _$RequestMessageCopyWith<$Res> {
  __$RequestMessageCopyWithImpl(this._self, this._then);

  final _RequestMessage _self;
  final $Res Function(_RequestMessage) _then;

/// Create a copy of RequestMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_RequestMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RequestBody {

 String get model; List<RequestMessage> get messages;
/// Create a copy of RequestBody
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestBodyCopyWith<RequestBody> get copyWith => _$RequestBodyCopyWithImpl<RequestBody>(this as RequestBody, _$identity);

  /// Serializes this RequestBody to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestBody&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'RequestBody(model: $model, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $RequestBodyCopyWith<$Res>  {
  factory $RequestBodyCopyWith(RequestBody value, $Res Function(RequestBody) _then) = _$RequestBodyCopyWithImpl;
@useResult
$Res call({
 String model, List<RequestMessage> messages
});




}
/// @nodoc
class _$RequestBodyCopyWithImpl<$Res>
    implements $RequestBodyCopyWith<$Res> {
  _$RequestBodyCopyWithImpl(this._self, this._then);

  final RequestBody _self;
  final $Res Function(RequestBody) _then;

/// Create a copy of RequestBody
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? model = null,Object? messages = null,}) {
  return _then(_self.copyWith(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<RequestMessage>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _RequestBody implements RequestBody {
  const _RequestBody({required this.model, required final  List<RequestMessage> messages}): _messages = messages;
  factory _RequestBody.fromJson(Map<String, dynamic> json) => _$RequestBodyFromJson(json);

@override final  String model;
 final  List<RequestMessage> _messages;
@override List<RequestMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of RequestBody
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestBodyCopyWith<_RequestBody> get copyWith => __$RequestBodyCopyWithImpl<_RequestBody>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestBodyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestBody&&(identical(other.model, model) || other.model == model)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,model,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'RequestBody(model: $model, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$RequestBodyCopyWith<$Res> implements $RequestBodyCopyWith<$Res> {
  factory _$RequestBodyCopyWith(_RequestBody value, $Res Function(_RequestBody) _then) = __$RequestBodyCopyWithImpl;
@override @useResult
$Res call({
 String model, List<RequestMessage> messages
});




}
/// @nodoc
class __$RequestBodyCopyWithImpl<$Res>
    implements _$RequestBodyCopyWith<$Res> {
  __$RequestBodyCopyWithImpl(this._self, this._then);

  final _RequestBody _self;
  final $Res Function(_RequestBody) _then;

/// Create a copy of RequestBody
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? model = null,Object? messages = null,}) {
  return _then(_RequestBody(
model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<RequestMessage>,
  ));
}


}


/// @nodoc
mixin _$ResponseMessage {

 String get role; String get content;
/// Create a copy of ResponseMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResponseMessageCopyWith<ResponseMessage> get copyWith => _$ResponseMessageCopyWithImpl<ResponseMessage>(this as ResponseMessage, _$identity);

  /// Serializes this ResponseMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResponseMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ResponseMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class $ResponseMessageCopyWith<$Res>  {
  factory $ResponseMessageCopyWith(ResponseMessage value, $Res Function(ResponseMessage) _then) = _$ResponseMessageCopyWithImpl;
@useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class _$ResponseMessageCopyWithImpl<$Res>
    implements $ResponseMessageCopyWith<$Res> {
  _$ResponseMessageCopyWithImpl(this._self, this._then);

  final ResponseMessage _self;
  final $Res Function(ResponseMessage) _then;

/// Create a copy of ResponseMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? role = null,Object? content = null,}) {
  return _then(_self.copyWith(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ResponseMessage implements ResponseMessage {
  const _ResponseMessage({required this.role, required this.content});
  factory _ResponseMessage.fromJson(Map<String, dynamic> json) => _$ResponseMessageFromJson(json);

@override final  String role;
@override final  String content;

/// Create a copy of ResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResponseMessageCopyWith<_ResponseMessage> get copyWith => __$ResponseMessageCopyWithImpl<_ResponseMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResponseMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResponseMessage&&(identical(other.role, role) || other.role == role)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,role,content);

@override
String toString() {
  return 'ResponseMessage(role: $role, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ResponseMessageCopyWith<$Res> implements $ResponseMessageCopyWith<$Res> {
  factory _$ResponseMessageCopyWith(_ResponseMessage value, $Res Function(_ResponseMessage) _then) = __$ResponseMessageCopyWithImpl;
@override @useResult
$Res call({
 String role, String content
});




}
/// @nodoc
class __$ResponseMessageCopyWithImpl<$Res>
    implements _$ResponseMessageCopyWith<$Res> {
  __$ResponseMessageCopyWithImpl(this._self, this._then);

  final _ResponseMessage _self;
  final $Res Function(_ResponseMessage) _then;

/// Create a copy of ResponseMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? role = null,Object? content = null,}) {
  return _then(_ResponseMessage(
role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Choice {

@JsonKey(name: 'finish_reason') String get finishReason; int get index; ResponseMessage get message;
/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChoiceCopyWith<Choice> get copyWith => _$ChoiceCopyWithImpl<Choice>(this as Choice, _$identity);

  /// Serializes this Choice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Choice&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.index, index) || other.index == index)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,finishReason,index,message);

@override
String toString() {
  return 'Choice(finishReason: $finishReason, index: $index, message: $message)';
}


}

/// @nodoc
abstract mixin class $ChoiceCopyWith<$Res>  {
  factory $ChoiceCopyWith(Choice value, $Res Function(Choice) _then) = _$ChoiceCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'finish_reason') String finishReason, int index, ResponseMessage message
});


$ResponseMessageCopyWith<$Res> get message;

}
/// @nodoc
class _$ChoiceCopyWithImpl<$Res>
    implements $ChoiceCopyWith<$Res> {
  _$ChoiceCopyWithImpl(this._self, this._then);

  final Choice _self;
  final $Res Function(Choice) _then;

/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? finishReason = null,Object? index = null,Object? message = null,}) {
  return _then(_self.copyWith(
finishReason: null == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ResponseMessage,
  ));
}
/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResponseMessageCopyWith<$Res> get message {
  
  return $ResponseMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _Choice implements Choice {
  const _Choice({@JsonKey(name: 'finish_reason') required this.finishReason, required this.index, required this.message});
  factory _Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);

@override@JsonKey(name: 'finish_reason') final  String finishReason;
@override final  int index;
@override final  ResponseMessage message;

/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChoiceCopyWith<_Choice> get copyWith => __$ChoiceCopyWithImpl<_Choice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Choice&&(identical(other.finishReason, finishReason) || other.finishReason == finishReason)&&(identical(other.index, index) || other.index == index)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,finishReason,index,message);

@override
String toString() {
  return 'Choice(finishReason: $finishReason, index: $index, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ChoiceCopyWith<$Res> implements $ChoiceCopyWith<$Res> {
  factory _$ChoiceCopyWith(_Choice value, $Res Function(_Choice) _then) = __$ChoiceCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'finish_reason') String finishReason, int index, ResponseMessage message
});


@override $ResponseMessageCopyWith<$Res> get message;

}
/// @nodoc
class __$ChoiceCopyWithImpl<$Res>
    implements _$ChoiceCopyWith<$Res> {
  __$ChoiceCopyWithImpl(this._self, this._then);

  final _Choice _self;
  final $Res Function(_Choice) _then;

/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? finishReason = null,Object? index = null,Object? message = null,}) {
  return _then(_Choice(
finishReason: null == finishReason ? _self.finishReason : finishReason // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as ResponseMessage,
  ));
}

/// Create a copy of Choice
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResponseMessageCopyWith<$Res> get message {
  
  return $ResponseMessageCopyWith<$Res>(_self.message, (value) {
    return _then(_self.copyWith(message: value));
  });
}
}


/// @nodoc
mixin _$ChatCompletion {

 String get id; int get created; String get model;@JsonKey(name: 'object') String get objectValue; List<Choice> get choices;
/// Create a copy of ChatCompletion
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCompletionCopyWith<ChatCompletion> get copyWith => _$ChatCompletionCopyWithImpl<ChatCompletion>(this as ChatCompletion, _$identity);

  /// Serializes this ChatCompletion to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatCompletion&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.model, model) || other.model == model)&&(identical(other.objectValue, objectValue) || other.objectValue == objectValue)&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,model,objectValue,const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'ChatCompletion(id: $id, created: $created, model: $model, objectValue: $objectValue, choices: $choices)';
}


}

/// @nodoc
abstract mixin class $ChatCompletionCopyWith<$Res>  {
  factory $ChatCompletionCopyWith(ChatCompletion value, $Res Function(ChatCompletion) _then) = _$ChatCompletionCopyWithImpl;
@useResult
$Res call({
 String id, int created, String model,@JsonKey(name: 'object') String objectValue, List<Choice> choices
});




}
/// @nodoc
class _$ChatCompletionCopyWithImpl<$Res>
    implements $ChatCompletionCopyWith<$Res> {
  _$ChatCompletionCopyWithImpl(this._self, this._then);

  final ChatCompletion _self;
  final $Res Function(ChatCompletion) _then;

/// Create a copy of ChatCompletion
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? created = null,Object? model = null,Object? objectValue = null,Object? choices = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,objectValue: null == objectValue ? _self.objectValue : objectValue // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<Choice>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ChatCompletion implements ChatCompletion {
  const _ChatCompletion({required this.id, required this.created, required this.model, @JsonKey(name: 'object') required this.objectValue, required final  List<Choice> choices}): _choices = choices;
  factory _ChatCompletion.fromJson(Map<String, dynamic> json) => _$ChatCompletionFromJson(json);

@override final  String id;
@override final  int created;
@override final  String model;
@override@JsonKey(name: 'object') final  String objectValue;
 final  List<Choice> _choices;
@override List<Choice> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of ChatCompletion
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCompletionCopyWith<_ChatCompletion> get copyWith => __$ChatCompletionCopyWithImpl<_ChatCompletion>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatCompletionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatCompletion&&(identical(other.id, id) || other.id == id)&&(identical(other.created, created) || other.created == created)&&(identical(other.model, model) || other.model == model)&&(identical(other.objectValue, objectValue) || other.objectValue == objectValue)&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created,model,objectValue,const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'ChatCompletion(id: $id, created: $created, model: $model, objectValue: $objectValue, choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$ChatCompletionCopyWith<$Res> implements $ChatCompletionCopyWith<$Res> {
  factory _$ChatCompletionCopyWith(_ChatCompletion value, $Res Function(_ChatCompletion) _then) = __$ChatCompletionCopyWithImpl;
@override @useResult
$Res call({
 String id, int created, String model,@JsonKey(name: 'object') String objectValue, List<Choice> choices
});




}
/// @nodoc
class __$ChatCompletionCopyWithImpl<$Res>
    implements _$ChatCompletionCopyWith<$Res> {
  __$ChatCompletionCopyWithImpl(this._self, this._then);

  final _ChatCompletion _self;
  final $Res Function(_ChatCompletion) _then;

/// Create a copy of ChatCompletion
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? created = null,Object? model = null,Object? objectValue = null,Object? choices = null,}) {
  return _then(_ChatCompletion(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,objectValue: null == objectValue ? _self.objectValue : objectValue // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<Choice>,
  ));
}


}

// dart format on
