import 'package:flutter/material.dart';

// 我的页面
class MyPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的'),),
      body: Column(
        children: const [Text( '我的' )],
      ),
    );
  }
}