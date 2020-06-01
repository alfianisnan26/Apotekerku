import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


void main() {
  final store =
      Store<AppState>(reducer, initialState: AppState(enableDarkMode: false));

  runApp(MyApp(store: store));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.store}) : super(key: key);

  final Store<AppState> store;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final store = widget.store;
    return StoreProvider<AppState>(
      store: store,
      child: AppBuilder(
        builder: (BuildContext context) {
          return MaterialApp(
            theme: ThemeData(
                brightness: store.state.enableDarkMode
                    ? Brightness.dark
                    : Brightness.light),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Test Redux App'),
              ),
              body: SettingsView(),
            ),
          );
        },
      ),
    );
  }
}

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final state = store.state;
      return SwitchListTile(
        title: Text('Dark Mode'),
        value: state.enableDarkMode,
        onChanged: (value) {
          store.dispatch(UpdateDarkMode(enable: !state.enableDarkMode));
          AppBuilder.of(context).rebuild();
        },
        secondary: Icon(Icons.settings),
      );
    });
  }
}

// Redux Claaes
class AppState {
  AppState({this.enableDarkMode});

  bool enableDarkMode;
}

class UpdateDarkMode {
  UpdateDarkMode({this.enable});

  final bool enable;
}

AppState reducer(AppState state, dynamic action) {
  if (action is UpdateDarkMode) {
    return AppState(
      enableDarkMode: action.enable,
    );
  }
  return state;
}

// App Builder
class AppBuilder extends StatefulWidget {
  const AppBuilder({Key key, this.builder}) : super(key: key);
  final Function(BuildContext) builder;

  @override
  AppBuilderState createState() => new AppBuilderState();

  static AppBuilderState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }

  void rebuild() {
    setState(() {});
  }
}