import 'package:flutter/material.dart';
// 首页底部导航器
class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final String name = "首页"
  final PageController _controller = PageController(
    initialPage: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text( name ) ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(), // 禁用屏幕滚动
        children: const [
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage()
        ],
      ),
    );
  }
}
