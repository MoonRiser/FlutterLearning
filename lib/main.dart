import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';         // NEW
import 'model/app_state_model.dart';             // NEW
import 'app.dart';

void main() {
  // This app is designed only to work vertically, so we limit
  // orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  return runApp( ChangeNotifierProvider<AppStateModel>(
      // 我们通过在整个 widget 层级的最上层实现 AppStateModel 来让它在整个 app 中都可以访问。
      //我们使用了 provider package 中的 ChangeNotifierProvider，它会监听 AppStateModel 变化所发出的通知。
    builder: (context) => AppStateModel()..loadProducts(),
    child: CupertinoStoreApp(),           // NEW
  ),);
}