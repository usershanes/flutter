import 'package:flutter/material.dart';

// 课程页面
class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('搜索'),),
      body: Column(
        children: const [Text( '搜索' )],
      ),
    );
  }
}
