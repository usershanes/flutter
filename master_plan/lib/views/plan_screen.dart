import 'package:master_plan/plan_provider.dart';

import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget{
  @override
  State createState() => _PlanScreen();
}

class _PlanScreen extends State<PlanScreen> {
  final plan = Plan();

  @override
  Widget build(BuildContext context) {
    // final plan = PlanProvider.of(context);
    return Scaffold(
        appBar: AppBar(title: Text('Master Plan')),
        body: Column(children: <Widget>[
          Expanded(child: _buildList()),
          SafeArea(child: Text(plan.completenessMessage))
        ]),
        floatingActionButton: _buildAddTaskButton());
  }

  _buildAddTaskButton() {
    final plan = PlanProvider.of(context);
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: (){
        setState(() {
          plan.tasks.add(Task());
        });
      },
    );
  }

  _buildList() {
    final plan = PlanProvider.of(context);
    return ListView.builder(
      itemCount: plan.tasks.length,
      itemBuilder: ( context, index ) => _buildTaskTile( plan.tasks[index] ),
    );
  }

  _buildTaskTile(Task task) {
    return ListTile(
      leading: Checkbox(
          value: task.complete,
          onChanged: (selected) {
              setState(() {
                task.complete = selected;
              });
          }),
        title: TextFormField(
          initialValue: task.description,
          onChanged: (text){
           setState(() {
             task.description = text;
            });
         },
       ),
     );
  }
}