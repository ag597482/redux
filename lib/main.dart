import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redu/utils/shared_pref_helper.dart';
import 'package:redux/redux.dart';

import 'helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int x = 5;
// Create store
  final store = Store<int>(counterReducer, initialState: 0);

  @override
  Widget build(BuildContext context) {
    SharedPreferenceService service = SharedPreferenceService();
    return Container(
      child: FutureBuilder<int>(
        future: service.getVal("count"),
        builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return StoreProvider(
        store: Store<int>(counterReducer, initialState: snapshot.data!),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Redux Counter',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: MyHomePage(),
        ),
      );
              }
        
      },)
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Redux Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter', style: TextStyle(fontSize: 24)),
            StoreConnector<int, String>(
              converter: (Store<int> store) => store.state.toString(),
              builder: (BuildContext context, String counter) {
                return Text(
                  counter,
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
             StoreProvider.of<int>(context).dispatch(Init());
            },
            child: Icon(Icons.refresh),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              StoreProvider.of<int>(context).dispatch(IncrementAction());
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              StoreProvider.of<int>(context).dispatch(DecrementAction());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
