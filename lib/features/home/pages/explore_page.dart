import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeteri/common/extensions.dart';
import 'package:meeteri/core/failure/failure.dart';

import '../../../common/widgets/custom_loading_indicator.dart';
import '../../post/blocs/post_bloc/post_bloc.dart';
import '../../post/models/post.dart';
import '../widgets/post_cart.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Page'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          return state.maybeMap(
              loading: (_) => const CustomLoadingIndicator(),
              failure: (f) => Text(f.failure.getMessage),
              loaded: (l) {
                return _buildExploreBody(l.posts);
              },
              orElse: () => const SizedBox.shrink());
        },
      ),
    );
  }

  _buildExploreBody(List<Post> posts) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
              onTap: (value) {
                _toggle();
              },
              tabs: const [
                Tab(
                  child: Text("Experience"),
                ),
                Tab(
                  child: Text("Study Materials"),
                ),
              ]),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 200),
            firstChild: Container(
              color: Colors.blue,
              child: PostCardsWidget(
                category: 'experience',
                posts: posts,
              ),
            ),
            secondChild: Container(
              color: Colors.red,
              child: PostCardsWidget(
                category: 'study-material',
                posts: posts,
              ),
            ),
            crossFadeState: _showFirst
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }
}
