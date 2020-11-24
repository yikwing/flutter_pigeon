import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/pagea.dart';
import 'package:flutter_module/pageb.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 实例化一个 MethodChannel
  MethodChannel _methodChannel = MethodChannel('com.example/method_channel');

  /// Flutter 页面入口
  Widget _initRoute = DefaultHomePage();

  @override
  void initState() {
    super.initState();

    _methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'setInitRoute':
          _handleInitRouteMethodCall(call);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home 设置成变量，当接收到 Android 发过来的路由时，
      // 将 home 修改以实现入口的切换
      home: _initRoute,
    );
  }

  /// 处理来自 setInitRoute 的消息
  void _handleInitRouteMethodCall(MethodCall call) async {
    switch (call.arguments) {
      case '/page_a':
        _initRoute = PageA();
        break;
      case '/page_b':
        _initRoute = PageB();
        break;
      default:
        _initRoute = DefaultHomePage();
        break;
    }

    /// 更新界面
    setState(() {});
  }
}

class DefaultHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 因为是路由栈的最底层，所以不会自动处理返回，我们要自己处理
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          // 退出 FlutterActivity，iOS 不支持，要单独处理
          onTap: () => SystemNavigator.pop(),
        ),
        title: Text('Default Home Page'),
      ),
      body: Container(),
    );
  }
}
