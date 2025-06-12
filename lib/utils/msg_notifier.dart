
import 'package:flutter/foundation.dart';

class MsgNotifier extends ChangeNotifier{
  String? _msg ;
  String? get msg => _msg;
  set msg(String? newMsg) {
    _msg = newMsg;
    notifyListeners();
  }
}