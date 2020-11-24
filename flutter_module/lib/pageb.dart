import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/pigeon.dart';

/// page_b.dart
class PageB extends StatefulWidget {
  @override
  _PageBState createState() => _PageBState();
}

/// page_a.dart
class _PageBState extends State<PageB> implements ApiToFlutter {
  String msg = "default";

  @override
  void initState() {
    super.initState();

    ApiToFlutter.setup(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => onBackPressed(context),
        ),
        title: Text('Page B'),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            CallBackMsg msg = CallBackMsg()
              ..callback = "flutterB代码"
              ..page = "B";
            ApiToNative().toHostMsg(msg);
          },
          child: Center(
            child: Text(msg),
          ),
        ),
      ),
    );
  }

  void onBackPressed(BuildContext context) {
    NavigatorState navigatorState = Navigator.of(context);
    if (navigatorState.canPop()) {
      navigatorState.pop();
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  void toFlutterMsg(SendMsg arg) {
    setState(() {
      msg = arg.msg;
    });
  }
}
