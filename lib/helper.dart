import 'package:redu/utils/shared_pref_helper.dart';
import 'package:redux/redux.dart';

// Define actions
class IncrementAction {}

class DecrementAction {}

class Init {}

// Define reducer
int counterReducer(int state, dynamic action) {
  SharedPreferenceService service = SharedPreferenceService();
  if (action is IncrementAction) {
    service.updateVal("count", state + 1);
    return state + 1;
  } else if (action is DecrementAction) {
    service.updateVal("count", state - 1);
    return state - 1;
  } else if (action is Init) {
    int x;
    service.getVal("count").then((value) {
      print("value returned is " + value.toString());
      x = value;
      return x;
    });
  }
  return state;
}
