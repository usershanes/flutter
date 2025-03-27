//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hello World',
          style: TextStyle(fontSize: 28),
        ),
        Text(
          'can wrap without issue',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing'
              'elit. Etiam at mauris massa. Suspendisse potenti'
              'Aenean aliquet eu nisl vitae tempus.'
        ),
      ],
    );
  }
}
