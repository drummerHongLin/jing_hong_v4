


import 'package:jing_hong_v4/data/data/auth/remote/auth_repo_remote.dart';
import 'package:jing_hong_v4/data/data/chat/local/chat_repo_local.dart';
import 'package:jing_hong_v4/data/data/chat/remote/chat_repo_remote.dart';
import 'package:jing_hong_v4/service/api/auth/auth_client.dart';
import 'package:jing_hong_v4/service/api/chat/chat_client.dart';
import 'package:jing_hong_v4/service/db/sqlite_db.dart';
import 'package:jing_hong_v4/service/preference/shared_preferences_servicec.dart';
import 'package:jing_hong_v4/ui/auth/auth_viewmodel.dart';
import 'package:jing_hong_v4/ui/chat/view_models/chat_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get localProviders {
  
  return [
    Provider(create: (_)=>ChatRepoLocal()),
    Provider(create: (context)=>ChatViewmodel(chatRepo: context.read<ChatRepoRemote>(), authRepo: context.read<AuthRepoRemote>()))
  ];

}


List<SingleChildWidget> get remoteProviders {
  return [

    Provider(create: (_)=>SqliteDb()),
    Provider(create: (_)=>ChatClient()),
    Provider(create: (_)=>SharedPreferencesService()),
    Provider(create: (_)=>AuthClient()),
    Provider(create: (context)=>AuthRepoRemote(preferencesService: context.read(), authClient: context.read())),
    Provider(create: (context)=>ChatRepoRemote(chapClient: context.read(), chatDb: context.read())),
    Provider(create: (context)=>ChatViewmodel(chatRepo: context.read<ChatRepoRemote>(), authRepo: context.read<AuthRepoRemote>())),
    Provider(create: (context)=>AuthViewmodel(authRepo: context.read<AuthRepoRemote>()))
  ];
}