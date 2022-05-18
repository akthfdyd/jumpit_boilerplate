import 'package:arc/arc_subject.dart';
import 'package:jumpit_boilerplate/presentation/viewmodel_interface.dart';
import 'package:jumpit_boilerplate/util/dev_log.dart';

// explain: ViewState -> enum or implements of abstract class
enum BottomTabViewState { HOME, MY }

class BottomTabViewModel implements ViewModelInterface {
  var tabState = ArcSubject<BottomTabViewState>();

  @override
  void loadState(state) {
    Log.i("BottomTabViewModel loadState $state");
    state = state as BottomTabViewState;
    tabState.val = state;
    Log.v("BottomTabViewModel tabState=${tabState.val}");
  }

  @override
  disposeAll() {
    Log.i("BottomTabViewModel disposeAll");
    tabState.close();
  }
}
