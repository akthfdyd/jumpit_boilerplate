import 'package:arc/arc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eval/flutter_eval.dart';
import 'package:jumpit_boilerplate/data/datasource/local/mock_data_store.dart';
import 'package:jumpit_boilerplate/presentation/screen/bottom_tab_view.dart';
import 'injection_container.dart' as ic;

/// {@category Architecture}
/// {@category ArchitectureKR}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MockDataStore(context);
    return HotSwapLoader(
      uri: '',
      strategy: HotSwapStrategy.immediate,
      child: MaterialApp(
        navigatorKey: Arc().navigatorKey,
        home: const BottomTabView(),
      ),
    );
  }
}
