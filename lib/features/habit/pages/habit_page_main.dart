import 'package:flutter/material.dart';
import 'package:meeteri/features/habit/pages/habit_progress.dart';
import 'package:meeteri/features/habit/pages/habit_task_page.dart';

class HabitPageMain extends StatefulWidget {
  const HabitPageMain({super.key});

  @override
  State<HabitPageMain> createState() => _HabitPageMainState();
}

class _HabitPageMainState extends State<HabitPageMain> {
  final List<String> _list = ["Tasks", "Progress"];
  final List<Widget> _widgets = [const HabitTaskPage(), const HabitProgress()];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: _list
                .map((e) => Tab(
                      child: Text(e),
                    ))
                .toList(),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.99,
          child: TabBarView(children: _widgets),
        ),
      ),
    );
  }
}
