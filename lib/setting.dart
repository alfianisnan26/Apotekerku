import 'package:flutter/material.dart';
import 'string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

var global = SharedPref();
var settings = _Settings();
var str = Strings();
var store;
var prefs = Prefs();

class SharedPref{
  Color color;
  int langid;
  int routine = 0;
  int ID = 0;
  bool sickness = false;
  String dob = DateTime.now().toString();
}

enum ConfirmAction { CANCEL, ACCEPT }
 
Future<ConfirmAction> confirmDialog(BuildContext context, final title, final content, final cancel, final ok) async {
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          FlatButton(
            child: Text(cancel),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text(ok),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}

class Prefs {

  void saveProfile(String value1, String value2)async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     pref.setString("${global.ID}_name", value1);
     pref.setString("${global.ID}_ill", value2);
     pref.setInt("${global.ID}_routine", global.routine);
     pref.setBool("${global.ID}_sickness", global.sickness);
     pref.setString("${global.ID}_dob", global.dob);
  }
  void savedarkmode() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("${global.ID}_darkMode", store.state.enableDarkMode);
  }

  void savesickness() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("${global.ID}_sickness", store.state.sickness);
  }

  Future<bool> getdarkmode() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var val = pref.getBool("${global.ID}_darkMode") ?? false;
    print("$val");
    store.state.enableDarkMode = val;
    return val;
  }

  Future<bool> savelocale(int value) async
  {
     SharedPreferences pref = await SharedPreferences.getInstance();
     return pref.setInt("${global.ID}_locale", value);
  }

  void getudata() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var name = pref.getString("${global.ID}_name") ?? str.undefined;
    var val = pref.getInt("${global.ID}_locale") ?? 0;
    var ill = pref.getString("${global.ID}_profile") ?? str.undefined;
    global.dob = pref.getString("${global.ID}_dob") ?? DateTime.now().toString().split(' ')[0];
    global.sickness = pref.getBool("${global.ID}_sickness") ?? false;
    str.lang(val);
    print('$name | $ill | Lang ${str.localestr[val]} | DOB ${global.dob}');
    str.name = name;
    str.illness = ill;
    str.names = name.split(' ');
  }
}

class _Settings{
  ThemeMode theme(){
    if(!store.state.enableDarkMode){
      global.color = Colors.blue;
      return ThemeMode.light;
    }
    else {
      global.color = Colors.black54;
      return ThemeMode.dark;
    }
  }

  Future<bool> init() async{
    prefs.getdarkmode();
    prefs.getudata();
    return true;
  }
}

void push(var context, var onthego){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => onthego));
}

void pop(var context){
  Navigator.of(context).pop();
}

void replace(var context, var onthego){
 Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => onthego));
}

// Redux Claaes
class AppState {
  bool enableDarkMode;
  AppState({this.enableDarkMode});
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

class LangSetting extends StatefulWidget{
  @override
  _LangSetting createState() => _LangSetting();
}

class _LangSetting extends State<LangSetting>{
  @override
  Widget build(BuildContext context){
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store){ 
      return Scaffold(
      appBar: AppBar(
        title: Text(str.langs),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: <Widget>[
          FlatButton(onPressed: () async{
            final ConfirmAction action = await confirmDialog(context, str.msg2, str.msg1, str.cancel,str.restartNow);
            if(action == ConfirmAction.ACCEPT){RestartWidget.restartApp(context);
              prefs.savelocale(1).then((value) => RestartWidget.restartApp(context));
            }
            else pop(context);
          }, child: Text(str.localestr[1])),
          FlatButton(onPressed: () async{
            
            final ConfirmAction action = await confirmDialog(context, str.msg2, str.msg1, str.cancel,str.restartNow);
            if(action == ConfirmAction.ACCEPT){
              prefs.savelocale(0).then((value) => RestartWidget.restartApp(context));
            }
            else pop(context);
          }, child: Text(str.localestr[0])),
        ],
      )
    );});
  }
}


class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

 Widget routineCard(Widget _child, void Function() _routine, Color _color, void Function() _longPress) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(5),
          child: RaisedButton(
              color: _color,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0)),
              elevation: 5,
              onPressed: _routine,
              onLongPress: _longPress,
              child: _child)),
      width: 100,
    );
  }

  Future<String> renameUser(BuildContext context) async {
  String name = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false, // dialog is dismissible with a tap on the barrier
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(str.msg3),
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: str.realname, hintText: "George Washington"),
              onChanged: (value) {
                name = value;
              },
            ))
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(str.cancel),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
          FlatButton(
            child: Text(str.yes),
            onPressed: () {
              Navigator.of(context).pop(name);
            },
          ),
          
        ],
      );
    },
  );
}

Future<DateTime> setDOB(context) async{
  final time = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());
  return time;
}