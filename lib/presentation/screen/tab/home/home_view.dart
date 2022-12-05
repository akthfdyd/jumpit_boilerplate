import 'package:flutter/material.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/home/home_viewmodel.dart';

/// {@category Screen}
/// 홈탭 화면 [_HomeScreenState]
/// - Project: http://www.groupware.com/projectnumber
/// - Design: http://www.designaddress.com/projectnumber
/// - Specification: http://www.specandwireframe.com/projectnumber
/// ***
/// # Dev TC
/// #### [o] 중앙에 텍스트가 표시되는가
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var homeViewModel = it<HomeViewModel>();

  @override
  void initState() {
    homeViewModel.loadState(HomeViewState.START);
    super.initState();
  }

  @override
  void dispose() {
    homeViewModel.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffaaaaaa),
      child: const Center(child: Text("HOME")),
    );
  }
}
