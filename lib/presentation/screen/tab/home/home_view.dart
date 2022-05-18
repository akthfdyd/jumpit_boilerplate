import 'package:arc/arc.dart';
import 'package:flutter/material.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/home/home_viewmodel.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

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
