import 'package:cycle_store_app/api/client.dart';
import 'package:cycle_store_app/auth/guard.dart';

class ClientFactory {
  static Future<Client> create() async {
    String? token = await UserGuard().get();
    if(token == null) {
      throw Exception('The user is not logged in');
    }
    return Client(token);
  }
}