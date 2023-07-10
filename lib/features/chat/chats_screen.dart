import 'dart:developer';

import 'package:bimarestan_doctors/core/resources/color_manager.dart';
import 'package:bimarestan_doctors/features/chat/models/conversation.dart';
import 'package:bimarestan_doctors/features/user/data/models/user_credentials_model.dart';
import 'package:bimarestan_doctors/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../user/data/datasources/user_local_data_source.dart';
import 'chats_view_model.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late final Future<UserCredentialsModel?> userFuture;
  @override
  void initState() {
    userFuture = locator<UserLocalDataSource>().getUserCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserCredentialsModel?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final user = snapshot.data!;
            return ChangeNotifierProvider<ChatsViewModel>(
              create: (context) => ChatsViewModel()
                ..init(user.id, user.fullName ?? 'hidden name'),
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Chats'),
                ),
                body: Consumer<ChatsViewModel>(
                  builder: (context, model, child) {
                    return StreamBuilder<List<Conversation>>(
                      stream: model.conversationsStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            log(snapshot.error.toString());
                            log(snapshot.stackTrace.toString());
                            return Center(
                              child: Text(
                                'Internet connection error, waiting for reconnect...',
                                textAlign: TextAlign.center,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final conversations = snapshot.data!;
                            if (conversations.isEmpty)
                              return Center(
                                  child: Text(
                                'You have no conversations',
                                textAlign: TextAlign.center,
                              ));
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      Routes.chat,
                                      arguments: {
                                        'senderId': user.id,
                                        'senderName': user.fullName,
                                        'recieverId':
                                            conversations[index].getOtherUserId(
                                          model.userId,
                                        ),
                                        'recieverName': conversations[index]
                                            .getOtherUserName(
                                          model.userId,
                                          model.userName,
                                        )
                                      },
                                    );
                                  },
                                  shape: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundColor:
                                        ColorManager.primary.withOpacity(0.5),
                                  ),
                                  title: Text(
                                    conversations[index].getOtherUserName(
                                      model.userId,
                                      model.userName,
                                    ),
                                  ),
                                  subtitle: Text(
                                    conversations[index].lastMessage.text,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No data found',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              'Internet connection error, waiting for reconnect...',
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            );
          }
          return SizedBox();
        });
  }
}
