import 'dart:developer';

import 'package:bimarestan_doctors/core/utils/extensions.dart';
import 'package:bimarestan_doctors/features/chat/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/shared/loading_widget.dart';
import '../../core/shared/something_went_wrong_widget.dart';
import '../../core/state_management/view_state.dart';
import 'message_card.dart';
import 'models/message.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.senderId,
    required this.senderName,
    required this.recieverId,
    required this.recieverName,
  });
  final int senderId;
  final String senderName;
  final int recieverId;
  final String recieverName;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatViewModel()
        ..init(
          doctorId: recieverId,
          doctorName: recieverName,
          patientId: senderId,
          patientName: senderName,
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'dr. $recieverName',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Consumer<ChatViewModel>(
          builder: (context, model, _) {
            switch (model.viewState) {
              case ViewState.initial:
              case ViewState.loading:
                return const LoadingWidget();
              case ViewState.error:
                return const Center(
                  child: Text(
                    'Something went wrong',
                  ),
                );
              case ViewState.success:
                return StreamBuilder<List<Message>>(
                  stream: model.conversationId != null
                      ? model.messagesStream
                      : model.emptyStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget();
                    } else if (snapshot.connectionState ==
                            ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return SomethingWentWrongWidget(
                          onTap: () {},
                        );
                      } else {
                        log(snapshot.data.toString());
                        return Column(
                          children: [
                            if (snapshot.data!.isEmpty)
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    'No messages yet',
                                  ),
                                ),
                              )
                            else
                              Expanded(
                                child: ListView.builder(
                                  padding: const EdgeInsets.all(16),
                                  reverse: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final message = snapshot.data![index];
                                    return MessageCard(
                                      isMe: message.senderId == senderId,
                                      message: message.text,
                                      images: message.images,
                                      createdAt:
                                          message.createdAt ?? DateTime.now(),
                                    );
                                  },
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (model.images.isNotEmpty)
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 80.h,
                                              child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: model.images.length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 8.w,
                                                  );
                                                },
                                                itemBuilder: (context, index) {
                                                  final image =
                                                      model.images[index];
                                                  return Container(
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.25),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        8.r,
                                                      ),
                                                    ),
                                                    child: Image.file(
                                                      image,
                                                      height: 80.h,
                                                      width: 80.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            color: context.colorScheme.primary,
                                            onPressed: () {
                                              model.clearImages();
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: model.messageController,
                                          minLines: 1,
                                          maxLines: 3,
                                          keyboardType: TextInputType.multiline,
                                          textInputAction:
                                              TextInputAction.newline,
                                          decoration: const InputDecoration(
                                            hintText: 'Type a message',
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        visualDensity: VisualDensity.compact,
                                        color: context.colorScheme.primary,
                                        onPressed: () {
                                          model.pickImages();
                                        },
                                        icon: const Icon(Icons.attachment),
                                      ),
                                      AnimatedBuilder(
                                          animation: model.messageController,
                                          builder: (context, child) {
                                            return IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              color:
                                                  context.colorScheme.primary,
                                              onPressed: model.messageController
                                                          .text
                                                          .trim()
                                                          .isNotEmpty ||
                                                      model.images.isNotEmpty
                                                  ? () {
                                                      model.sendMessage();
                                                    }
                                                  : null,
                                              icon: const Icon(Icons.send),
                                            );
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const Text('empty');
                    }
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
