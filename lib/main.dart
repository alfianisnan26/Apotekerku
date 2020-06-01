import 'package:flutter/material.dart';
import 'dart:io';
import 'setting.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'launcher.dart';
import 'package:random_color/random_color.dart';
import 'routine.dart';

String avatar = "assets/avatar/(1).png";
String bg = "assets/global/bg.png";
Widget titleApp = Image.asset("assets/global/title.png");

void main() {
  store =
      Store<AppState>(reducer, initialState: AppState(enableDarkMode: false));
  runApp(RestartWidget(child: Apotekerku(store: store)));
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class RoutineCard {
  String name;
  int val;
  DateTime sched;
  int index;
  Color color=Colors.yellow;

  RoutineCard(String name, int val, DateTime sched, int index, Color color){
    this.name = name;
    this.val = val;
    this.sched = sched;
    this.index = index;
    this.color = color;
  }

  String sum(){
    return "Index : ${this.index}\nName : ${this.name}\nValue: ${this.val}";
  }

  Widget widget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${this.index}"),
        Text("${this.name}"),
        Text("${this.val}"),
        Text("${this.sched.toString().split(' ')[0].split('-')[0]}"),
      ],
    );
  }
}

class _HomeScreen extends State<HomeScreen> {
  IconData viewIcon = Icons.view_day;

  @override
  void initState() {
    super.initState();
  }

  Widget routineApps(var context, bool dm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Container(
            height: 120,
            child: ListView.builder(
                itemCount: cards.length+3,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  Widget ret;
                  if(index == 0 || index == cards.length+2){
                    ret = SizedBox(width: 10,);
                  }
                  else if (index == 1) {
                    ret = Container(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                              color: dm?ThemeData.dark().accentColor:ThemeData.light().accentColor,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0)),
                              elevation: 5,
                              onPressed: () => addRoutine(context),
                              child: Icon(Icons.add))),
                      width: 100,
                    );
                  } else if(index > 1){
                    ret = Container(
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                              color: cards[index-2].color,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(8.0)),
                              elevation: 5,
                              onPressed: () {
                                print("Pressed $index");
                                push(context,RoutineView(rc: cards[index-2], index: index-2));
                              },
                              onLongPress: () async{
                                final ConfirmAction action = await confirmDialog(context, str.msg6, cards[index-2].sum(), str.delete, str.cancel);
                                if(action == ConfirmAction.CANCEL){
                                  print("LongPressed $index Deleted");
                                  setState(() {
                                     cards.removeAt(index-2);
                                  });
                                }
                                else{
                                  print("LongPressed $index  Cancel");
                                }
                                
                              },
                              child: cards[index-2].widget())),
                      width: 100,
                    );
                  }
                  return ret;
                }))
      ],
    );
  }
  List<RoutineCard> cards =[];

  void addRoutine(BuildContext context) async{
    final RoutineCard rc = RoutineCard(str.rou, cards.length, DateTime.now(), 0, global.color);
    bool res = await Navigator.push(context, MaterialPageRoute(builder: (context) => RoutineView(rc:rc))) ;
    if (res == null) res = false;
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: res? Text(str.saved):Text(str.canceled)));
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      bool dm = store.state.enableDarkMode;
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          drawer: Drawer(
              child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                    color: global.color,
                    image: DecorationImage(
                        image: ExactAssetImage(
                          bg,
                        ),
                        fit: BoxFit.cover)),
                accountName: Text(str.name),
                accountEmail: Text(global.sickness ? str.illness : str.healthy),
                currentAccountPicture: CircleAvatar(
                  child: Image.asset(avatar),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text(str.addUser),
              ),
              ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(str.setting),
                  onTap: () => push(context, Setting())),
              ListTile(
                leading: Icon(Icons.help),
                title: Text(str.help),
                onTap: () => null,
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(str.about),
                onTap: () => null,
              ),
              ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(str.exit),
                  onTap: () => exit(0))
            ],
          )),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: str.dashboard,
                ),
                Tab(text: str.routine),
                Tab(text: str.apps),
                Tab(
                  icon: Icon(Icons.warning, color: Colors.yellow),
                ),
              ],
            ),
            centerTitle: true,
            title: SizedBox(
              width: 80,
              child: titleApp,
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              routineApps(context, dm),
              Icon(Icons.directions_transit),
              Icon(Icons.warning),
            ],
          ),
        ),
      );
    });
  }
}

class Setting extends StatefulWidget {
  @override
  _Setting createState() => _Setting();
}

class _Setting extends State<Setting> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (BuildContext context, Store<AppState> store) {
      final state = store.state;
      return Scaffold(
        appBar: AppBar(
          title: Text(str.setting),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: str.profile,
              tiles: [
                SettingsTile(
                    title: str.realname,
                    leading: Icon(Icons.person),
                    subtitle: str.name,
                    onTap: () => {
                          renameUser(context).then((value) {
                            if (value != null) str.name = value;
                            prefs.saveProfile(str.name, str.illness);
                            setState(() {});
                          })
                        }),
                SettingsTile.switchTile(
                  title: str.sick,
                  switchValue: global.sickness,
                  leading: Icon(global.sickness
                      ? Icons.sentiment_very_dissatisfied
                      : Icons.sentiment_satisfied),
                  onToggle: (value) {
                    setState(() {
                      global.sickness = value;
                      prefs.saveProfile(str.name, str.illness);
                    });
                  },
                ),
                SettingsTile(
                  enabled: global.sickness,
                  title: str.ill,
                  subtitle: global.sickness ? str.illness : str.healthy,
                  leading: Icon(Icons.accessible),
                  onTap: () => prefs.saveProfile(str.name, str.illness),
                ),
                SettingsTile(
                    title: str.dob,
                    leading: Icon(Icons.calendar_today),
                    subtitle: global.dob,
                    onTap: () => {
                          setDOB(context).then((value) {
                            if(value!=null){
                            prefs.saveProfile(str.name, str.ill);
                            setState(() {
                              global.dob = value.toString().split(' ')[0];
                            });
                            }
                          })
                        }),
                SettingsTile(
                  title: str.deleteacc,
                  leading: Icon(Icons.delete_forever),
                  onTap: () async {
                    final ConfirmAction action = await confirmDialog(
                        context, str.msg5, str.msg4, str.cancel, str.delete);
                    if (action == ConfirmAction.ACCEPT) {
                    } else {
                    }
                  },
                ),
              ],
            ),
            SettingsSection(
              title: str.general,
              tiles: [
                SettingsTile(
                    title: str.langs,
                    subtitle: str.currentlangs,
                    leading: Icon(Icons.language),
                    onTap: () => push(context, LangSetting())),
                SettingsTile.switchTile(
                  title: str.theme,
                  leading: Icon(Icons.wb_sunny),
                  switchValue: state.enableDarkMode,
                  onToggle: (value) {
                    store.dispatch(
                        UpdateDarkMode(enable: !state.enableDarkMode));
                    AppBuilder.of(context).rebuild();
                    prefs.savedarkmode();
                  },
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
