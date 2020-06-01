import 'package:apotekerku/main.dart';
import 'package:flutter/material.dart';

class RoutineView extends StatefulWidget{
  final RoutineCard rc;
  final int index;
  const RoutineView({Key key, this.rc, this.index}) : super(key :key);
  @override
  _routineView createState() => _routineView();
}

class _routineView extends State<RoutineView>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.rc.color,
        title: Text(widget.rc.name),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.save),
        onPressed: () => Navigator.of(context).pop(true)),
    );
  }
}