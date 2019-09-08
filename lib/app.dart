import 'package:cupertino_store/particles/run_ball.dart';
import 'package:flutter/cupertino.dart';
import 'product_list_tab.dart';
import 'search_tab.dart';
import 'shopping_cart_tab.dart';
import 'package:provider/provider.dart';
import 'model/app_state_model.dart';

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var model = Provider.of<AppStateModel>(context);
    return CupertinoApp(
      home: CupertinoStoreHomePage(),
      theme: model.themeData,
      //theme: CupertinoThemeData(brightness: Brightness.dark),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text('Products'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            title: Text('Cart'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.pen),
            title: Text('Test'),
          ),

        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SearchTab(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShoppingCartTab(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context){
              return CupertinoPageScaffold(
                  child: RunBall());
            },);
            break;
        }
        return returnValue;
      },
    );
  }
}