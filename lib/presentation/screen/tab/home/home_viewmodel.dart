import 'package:arc/arc_subject.dart';
import 'package:jumpit_boilerplate/presentation/viewmodel_interface.dart';

enum HomeViewState { START, FETCHED, ERROR }

/// {@category ViewModel}
class HomeViewModel implements ViewModelInterface {
  // section: view state
  final viewState = ArcSubject<HomeViewState>();

  @override
  void loadState(state) {
    state = state as HomeViewState;
    viewState.val = state;
  }

  @override
  disposeAll() {
    viewState.close();
  }
}
