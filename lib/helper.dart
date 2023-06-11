import 'package:redux/redux.dart';

// Define actions
class IncrementAction {}

class DecrementAction {}

// Define reducer
int counterReducer(int state, dynamic action) {
  if (action is IncrementAction) {
    return state + 1;
  } else if (action is DecrementAction) {
    return state - 1;
  }
  return state;
}

// Create store
final store = Store<int>(counterReducer, initialState: 0);
