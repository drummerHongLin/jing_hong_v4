import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

abstract class Tools {
  static String generateUuid(String namespace, String? value) {
    final sendTime = DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now());

    var uuid = Uuid();

    return uuid.v5(Uuid.NAMESPACE_URL, "$namespace - $sendTime - ${value ?? "未登录用户"}");
  }
}
