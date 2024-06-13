import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meeteri/common/widgets/build_avatar_image.dart';
import 'package:meeteri/common/widgets/custom_loading_indicator.dart';
import 'package:meeteri/dependency_injection.dart';
import 'package:meeteri/features/chat/blocs/messaged_users_cubit/messaged_users_cubit.dart';
import 'package:meeteri/features/chat/models/chat_room.dart';
import 'package:meeteri/router.dart';

class MessagedUserPage extends StatefulWidget {
  const MessagedUserPage({super.key});

  @override
  State<MessagedUserPage> createState() => _MessagedUserPageState();
}

class _MessagedUserPageState extends State<MessagedUserPage> {
  @override
  void initState() {
    sl<MessagedUsersCubit>().getMessagedUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: BlocBuilder<MessagedUsersCubit, MessagedUsersState>(
        builder: (context, state) {
          if (state is MessagedUsersLoading) {
            return const CustomLoadingIndicator();
          } else if (state is MessagedUsersLoaded) {
            log("###############");
            log(state.messagedUsers.length.toString());
            return _messagedUsers(state.messagedUsers);
          }
          return const Text("There is no chats to show");
        },
      ),
    );
  }

  Widget _messagedUsers(List<ChatRoomIndividual> users) {
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return InkWell(
            onTap: () => _onTapMessagedUser(user),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card.filled(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: SizedBox(
                      height: 40,
                      width: 40,
                      child: BuildAvatarImageNetwork(
                        image: user.messagedUser.avatar,
                      ),
                    ),
                    title: Text(user.messagedUser.username),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _onTapMessagedUser(ChatRoomIndividual user) {
    context.pushNamed(AppRouteName.chatPage, extra: user);
  }
}
