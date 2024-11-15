import 'package:arc/arc.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/stdlib/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eval/flutter_eval.dart';
import 'package:flutter_eval/widgets.dart';
import 'package:jumpit_boilerplate/injection_container.dart';
import 'package:jumpit_boilerplate/presentation/screen/tab/my/my_viewmodel.dart';

/// {@category Screen}
/// My탭 화면 [_MyScreenState]
/// - Project: http://www.groupware.com/projectnumber
/// - Design: http://www.designaddress.com/projectnumber
/// - Specification: http://www.specandwireframe.com/projectnumber
/// ***
/// # Dev TC
/// #### [o] 중앙에 텍스트가 표시되는가
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
    return HotSwap(
      id: '#my_view',
      args: [
        $BuildContext.wrap(context),
        $String(myViewModel.centerString.val),
        $Function((runtime, target, args) {
          myViewModel.centerString.val = 'new love';
          showDialog(
              context: Arc().currentContext,
              builder: (context) {
                return Center(child: Text("${myViewModel.centerString.val}"));
              });
        }),
      ],
      childBuilder: (context) {
        return Container(
          color: const Color(0xffccaaaa),
          child: const Center(child: Text("MY")),
        );
      },
    );
  }
}
