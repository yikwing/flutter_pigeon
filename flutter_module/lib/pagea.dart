import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/pigeon.dart';

class PageA extends StatefulWidget {
  @override
  _PageAState createState() => _PageAState();
}

/// page_a.dart
class _PageAState extends State<PageA> implements ApiToFlutter {
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
        title: Text('Page A'),
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            CallBackMsg msg = CallBackMsg()
              ..callback = "flutterA代码"
              ..page = "A";
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
