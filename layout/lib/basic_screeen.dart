import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout/immutable_widget.dart';
import 'package:layout/text_layout.dart';

class BasicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold 微件的用法
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Welcome to Flutter'),
        actions: <Widget>[
          Padding(padding: const EdgeInsets.all(10.0), child: Icon(Icons.edit),)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: ImmutableWidget(),
          ),
          TextLayout()
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: Center(
            child: Text('I m a Drawer!'),
          ),
        ),
      ),
    );
  }
}

