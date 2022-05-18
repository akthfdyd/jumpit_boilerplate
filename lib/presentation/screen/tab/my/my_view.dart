import 'package:flutter/material.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/my/my_viewmodel.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  var myViewModel = it<MyViewModel>();

  @override
  void initState() {
    myViewModel.loadState(MyViewState.START);
    super.initState();
  }

  @override
  void dispose() {
    myViewModel.disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffccaaaa),
      child: const Center(child: Text("MY")),
    );
  }
}
