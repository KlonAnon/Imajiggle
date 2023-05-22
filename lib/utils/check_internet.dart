import 'dart:io';

// Function for checking the internet connectivity by looking up the IP of google.com
Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    // if the dns lookup was a success and it returned a valid ip return true
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
    // catch SocketException (no network connection, DNS resolution fails, or target server is unreachable)
  } on SocketException catch (_) {
    return false;
  }
}
