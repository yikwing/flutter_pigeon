import 'package:pigeon/pigeon.dart';

class SendMsg {
  String msg;
}

class CallBackMsg {
  String page;
  String callback;
}

@FlutterApi()
abstract class ApiToFlutter {
  void toFlutterMsg(SendMsg msg);
}

@HostApi()
abstract class ApiToNative {
  void toHostMsg(CallBackMsg msg);
}
