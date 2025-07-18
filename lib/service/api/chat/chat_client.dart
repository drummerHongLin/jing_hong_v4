import 'package:dio/dio.dart';
import 'package:jing_hong_v4/data/data/chat/local/chat_model.dart';
import 'package:jing_hong_v4/service/api/chat/model/chat_api_data.dart';

class ChatClient {
  late final Map<String, Dio> _chatApis;
  late String currentModel;

  ChatClient() {
    _chatApis = {
      for (var e in chatModels)
        e.name: Dio(
          BaseOptions(
            baseUrl: e.requestUrl,
            headers: <String, dynamic>{"Authorization": e.authorization},
          ),
        ),
    };
    currentModel = chatModels.first.name;
  }

  void setChatModel(String modelName) {
    if (_chatApis.keys.contains(modelName)) {
      currentModel = modelName;
    } else {
      throw Exception("无效模型");
    }
  }

  Future<ChatCompletion> getChatCompletion(RequestBody body) async {
    final response = await _chatApis[currentModel]!.post(
      'chat/completions',
      data: body.toJson(),
    );
    return ChatCompletion.fromJson(response.data);
  }
}
