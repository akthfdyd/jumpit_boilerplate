import 'package:arc/arc_subject.dart';
import 'package:jumpit_boilerplate/presentation/viewmodel_interface.dart';

enum MyViewState { START, FETCHED, ERROR }

class MyViewModel implements ViewModelInterface {
  final viewState = ArcSubject<MyViewState>();

  @override
  void loadState(state) {
    state = state as MyViewState;
    viewState.val = state;
  }

  @override
  disposeAll() {
    viewState.close();
  }
}
