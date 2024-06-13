import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeteri/common/extensions.dart';
import 'package:meeteri/common/widgets/app_logo.dart';
import 'package:meeteri/features/therapy/pages/quote.dart';

import '../../../common/widgets/custom_loading_indicator.dart';
import '../../post/blocs/post_bloc/post_bloc.dart';
import '../../post/models/post.dart';
import '../widgets/post_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  bool _showFirst = true;
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Align(
            alignment: Alignment.topLeft,
            child: SizedBox(height: 30, child: AppLogo())),
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
      length: 3,
      initialIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TabBar(
                onTap: (value) {
                  if (value == 0 || value == 1) {
                    _toggle();
                  }
                  _currentValue = value;
                  setState(() {});
                },
                tabs: const [
                  Tab(
                    child: Text("Experiences"),
                  ),
                  Tab(
                    child: Text("Study Materials"),
                  ),
                  Tab(
                    child: Text("Quotes"),
                  ),
                ]),
            _currentValue == 0 || _currentValue == 1
                ? AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    firstChild: Container(
                      child: PostCardsWidget(
                        category: 'experience',
                        posts: posts,
                      ),
                    ),
                    secondChild: Container(
                      child: PostCardsWidget(
                        category: 'study-material',
                        posts: posts,
                      ),
                    ),
                    crossFadeState: _showFirst
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  )
                : QuotesPage(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }
}
