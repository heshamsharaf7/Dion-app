import 'package:flutter/material.dart';

class CustomTabWidget extends StatelessWidget {
  final int length;
  final List<Widget> tabs;
  final List<Widget> tabViews;

  CustomTabWidget({
    required this.length,
    required this.tabs,
    required this.tabViews,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: length,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: Colors.blue,
              ),
              insets: EdgeInsets.symmetric(horizontal: 16),
            ),
            tabs: tabs,
          ),
          Expanded(
            child: TabBarView(
              children: tabViews,
            ),
          ),
        ],
      ),
    );
  }
}
