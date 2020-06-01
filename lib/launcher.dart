import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';
import 'setting.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class Apotekerku extends StatefulWidget{
  const Apotekerku({Key key, this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  _Apotekerku createState() => _Apotekerku();
}

class _Apotekerku extends State<Apotekerku> with SingleTickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {
    final store = widget.store;
    return StoreProvider<AppState>(
      store: store,
      child: AppBuilder(
        builder: (BuildContext context) {
          return MaterialApp(
            title: "Apotekerku",
            home: Loader(),
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: settings.theme());
        }
      )
    );
  }
}

class Loader extends StatefulWidget{
  @override
  _Loader createState() => _Loader();
}

class _Loader extends State<Loader>{

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    settings.init();
    return new Timer(Duration(milliseconds: 500), onDoneLoading);
  }

  onDoneLoading() async {
    AppBuilder.of(context).rebuild();
    replace(context, Launcher());
  }
  
  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.transparent,
    );
  }
}

class Launcher extends StatefulWidget {
  @override
  _Launcher createState() => _Launcher();
}

class _Launcher extends State<Launcher> {

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(milliseconds: 2500), onDoneLoading);
  }

  onDoneLoading() async {
    replace(context, HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: global.color,
          image: DecorationImage(
            image: ExactAssetImage(
              bg,
            ),
            fit: BoxFit.cover)
        ),
        child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 120),
            child: titleApp
        ),
      ),
    );
  }
}