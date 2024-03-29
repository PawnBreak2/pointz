import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnectivity() async {
  final ConnectivityResult connectivityResult =
      await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}
