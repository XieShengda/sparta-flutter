import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sparta/core/models/enum/auth_request_type.dart';
import 'package:sparta/core/models/enum/loading_status.dart';
import 'package:sparta/core/redux/app/app_state.dart';
import 'package:sparta/core/redux/auth/auth_action.dart';
import 'package:sparta/core/redux/store.dart';
import 'package:sparta/res/colors.dart';
import 'package:sparta/ui/common/utils/auth_checker.dart';
import 'package:sparta/ui/common/utils/snack_bar_util.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final data = ['1', '2'];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _pageController;
  final List<Widget> pages = <Widget>[
    Center(
      key: UniqueKey(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              title: Text('sliver'),
              background: PageView(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        minHeight: double.infinity, minWidth: double.infinity),
                    child: Icon(Icons.account_circle),
                    decoration: BoxDecoration(color: Colors.lime),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: double.infinity, minWidth: double.infinity),
                    child: Icon(Icons.account_circle),
                    decoration: BoxDecoration(color: Colors.red),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        minHeight: double.infinity, minWidth: double.infinity),
                    child: Icon(Icons.account_circle),
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => ListTile(
                        title: Text('title$index'),
                      ),
                  childCount: 20),
            ),
          )
        ],
      ),
    ),
    Center(
      key: UniqueKey(),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 450,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('sliver'),
              background: Image.asset(
                'assets/images/background_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) => ListTile(
                        title: Text('title$index'),
                      ),
                  childCount: 20),
            ),
          )
        ],
      ),
    )
  ];

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store<AppState> store) {
        if (store.state.authState.requestStatus[AuthRequestType.login] ==
            LoadingStatus.success) {
          SnackBarUtil.textByKey(scaffoldKey, '登录成功');
          store.dispatch(InitAuthRequestStatusAction());
        }
      },
      onDidChange: (Store<AppState> store) {
        AuthChecker.check(context, store);
      },
      converter: (Store<AppState> store) => store,
      builder: (BuildContext context, Store<AppState> store) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[ const Text('杭州')],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => showDialog(
                context: context,
                builder: _buildDialog,
              ),
            ),
          ],
        ),
        body: pages[_pageIndex],
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: kShrineBrown900,
          ),
          onPressed: () {
            showDialog(context: context, builder: (context) => DemoDialog(),barrierDismissible: false);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.store,
                  color: _pageIndex == 0 ? Colors.lime : Colors.grey,
                ),
                onPressed: () => setState(() => _pageIndex = 0),
              ),
              SizedBox(),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: _pageIndex == 1 ? Colors.lime : Colors.grey,
                ),
                onPressed: () => setState(() => _pageIndex = 1),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDialog(BuildContext context) {
    return AlertDialog(
      title: Text('是否退出?'),
      actions: <Widget>[
        FlatButton(
          textTheme: ButtonTextTheme.normal,
          child: Text('cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          textTheme: ButtonTextTheme.normal,
          child: Text('ok'),
          onPressed: () => SpartaStore.dispatch(LogoutAction()),
        )
      ],
    );
  }
}

class DemoDialog extends Dialog {
  @override
  Widget build(BuildContext context) {
    return Material(
//      color: Colors.transparent,
      child: GestureDetector(
        child: Image.asset('assets/images/diamond.png'),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
