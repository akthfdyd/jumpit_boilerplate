import 'package:arc/arc.dart';
import 'package:flutter/material.dart';
import 'package:jumpit_boilerplate/data/datasource/local/temporary_data.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/screen/bottom_tab_viewmodel.dart';
import 'package:jumpit_boilerplate/presentation/screen/login/login_view.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/home/home_view.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/my/my_view.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

class BottomTabView extends StatefulWidget {
  const BottomTabView({Key? key}) : super(key: key);

  @override
  State<BottomTabView> createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var bottomTabViewModel = it<BottomTabViewModel>();

  @override
  void initState() {
    Log.i("BottomTabView initState");
    bottomTabViewModel.loadState(BottomTabViewState.HOME);
    super.initState();
  }

  @override
  void dispose() {
    Log.i("BottomTabView dispose");
    bottomTabViewModel.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: buildScaffoldBody(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Container buildScaffoldBody() {
    return Container(
      child: bottomTabViewModel.tabState.ui(builder: (context, tab) {
        if (!tab.hasData || tab.data.isNullOrEmpty) return Container();
        switch (tab.data) {
          case BottomTabViewState.MY:
            return const MyScreen();
          case BottomTabViewState.HOME:
          default:
            return const HomeScreen();
        }
      }),
    );
  }

  BottomAppBar buildBottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 0,
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // section: home
            Expanded(
              child: InkWell(
                  onTap: onClickHomeTab,
                  child: const Center(
                    child: Text("HOME"),
                  )),
            ),
            Container(
              width: 1,
              color: const Color(0xffaaaaaa),
            ),
            // section: my
            Expanded(
              child: InkWell(
                onTap: onClickMyTab,
                child: const Center(
                  child: Text("MY"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onClickHomeTab() {
    bottomTabViewModel.loadState(BottomTabViewState.HOME);
  }

  void onClickMyTab() {
    if (TemporaryData.isLogin) {
      bottomTabViewModel.loadState(BottomTabViewState.MY);
    } else {
      goLoginScreen();
    }
  }

  void goLoginScreen() {
    Arc.push(const LoginScreen()).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in success'),
          duration: Duration(seconds: 3),
        ),
      ),
    );
  }
}
