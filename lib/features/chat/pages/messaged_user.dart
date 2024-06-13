import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
            child: Card.outlined(
              child: Text(
                user.messagedUser.username,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        });
  }

  void _onTapMessagedUser(ChatRoomIndividual user) {
    context.pushNamed(AppRouteName.chatPage, extra: user);
  }
}
