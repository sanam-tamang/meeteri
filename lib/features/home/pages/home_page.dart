import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meeteri/features/chat/pages/chat_page.dart';
import 'package:meeteri/features/chat/pages/messaged_user.dart';
import 'package:meeteri/features/home/pages/explore_page.dart';
import 'package:meeteri/features/post/blocs/post_bloc/post_bloc.dart';
import 'package:meeteri/features/profile/pages/profile.dart';
import '../../../dependency_injection.dart';
import '/router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _visible = ValueNotifier(true);

  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    Text('Exercise Page'),
    Text('add btn'),
    MessagedUserPage(),
    UserProfileScreen(),
  ];

  @override
  void initState() {
    sl<PostBloc>().add(const PostEvent.get());
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///we gonna handle our operations here :)
  void _speedDialAction(BuildContext context, String title) {
    if (title == "Experience") {
      context.pushNamed(AppRouteName.createPost, extra: 'experience');
    } else if (title == "Study Material") {
      context.pushNamed(AppRouteName.createPost, extra: 'study-material');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(MdiIcons.compass),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.dumbbell),
            label: 'Exercise',
          ),
          NavigationDestination(
            icon: SpeedDial(
              foregroundColor: Colors.white,
              activeForegroundColor: Colors.yellow,
              activeIcon: MdiIcons.close,
              visible: _visible.value,
              backgroundColor: Theme.of(context).primaryColor,
              children: [
                SpeedDialChild(
                  // child: Text("Anonymous"),
                  backgroundColor: Colors.blue,
                  onTap: () => _speedDialAction(context, 'Experience'),
                  label: 'Experience',
                ),
                SpeedDialChild(
                  // child: const Icon(Icons.add_a_photo),
                  backgroundColor: Colors.teal,
                  onTap: () => _speedDialAction(context, 'Study Material'),
                  label: 'Study Material',
                ),
              ],
              child: Icon(MdiIcons.plus),
            ),
            label: '', // Remove label for SpeedDial
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.message),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(MdiIcons.account),
            label: 'UserProfile',
          ),
        ],
      ),
    );
  }
}
