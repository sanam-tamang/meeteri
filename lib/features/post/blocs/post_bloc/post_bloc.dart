import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/failure/failure.dart';
import '../../models/post.dart';
import '../../repositories/post_repositories.dart';

part 'post_event.dart';
part 'post_state.dart';
part 'post_bloc.freezed.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
 final  PostRepository _repository = PostRepository();
  PostBloc() : super(_Initial()) {
    on<PostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
