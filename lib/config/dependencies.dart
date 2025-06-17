


import 'package:jing_hong_v4/data/data/chat/local/chat_repo_local.dart';
import 'package:jing_hong_v4/data/data/chat/remote/chat_repo_remote.dart';
import 'package:jing_hong_v4/service/api/chat/chat_client.dart';
import 'package:jing_hong_v4/service/db/chat/chat_db.dart';
import 'package:jing_hong_v4/ui/chat/view_models.dart/chat_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get localProviders {
  
  return [
    Provider(create: (_)=>ChatRepoLocal()),
    Provider(create: (context)=>ChatViewmodel(chatRepo: context.read<ChatRepoLocal>()))
  ];

}


List<SingleChildWidget> get remoteProviders {
  return [
    Provider(create: (_)=>ChatDb()),
    Provider(create: (_)=>ChatClient()),
    Provider(create: (context)=>ChatRepoRemote(chapClient: context.read(), chatDb: context.read())),
    Provider(create: (context)=>ChatViewmodel(chatRepo: context.read<ChatRepoRemote>()))
  ];
}