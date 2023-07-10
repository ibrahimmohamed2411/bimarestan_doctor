import 'dart:async';
import 'dart:io';

// import '../../core/apis/error_handler.dart';
import '../../core/services/snack_bar_service.dart';
import '../../core/state_management/view_state.dart';
import '../../core/utils/dialogs.dart';
import '../../locator/locator.dart';
import 'data/chat_api.dart';
import 'data/images_api.dart';
import 'models/conversation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'models/message.dart';

@injectable
class ChatViewModel extends ChangeNotifier {
  final ChatAPI _api = ChatAPI();
  final ImagesApi _imagesApi = ImagesApi();
  final SnackBarService _snackBarService = locator<SnackBarService>();
  late final Stream<List<Message>> messagesStream;
  late final Conversation conversation;

  final TextEditingController messageController = TextEditingController();

  late int doctorId;
  late String doctorName;
  late int patientId;
  late String patientName;

  bool converstationExists = false;
  ViewState viewState = ViewState.loading;
  List<File> images = [];

  Future<void> init({
    required int doctorId,
    required String doctorName,
    required int patientId,
    required String patientName,
  }) async {
    this.doctorId = doctorId;
    this.doctorName = doctorName;
    this.patientId = patientId;
    this.patientName = patientName;
    viewState = ViewState.loading;
    notifyListeners();
    try {
      if (!converstationExists) {
        conversation = await _api.getConversationIfNotCreateOne(
          doctorId: doctorId,
          doctorName: doctorName,
          patientId: patientId,
          patientName: patientName,
        );
      }
      messagesStream = _api.getMessages(conversation.id);
      converstationExists = true;
      viewState = ViewState.success;
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
      viewState = ViewState.error;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    try {
      showLoadingDialog();
      final List<String> imageUrls = await _imagesApi.uploadImages(images);

      await _api.sendMessage(
        conversationId: conversation.id,
        senderId: patientId,
        recieverId: doctorId,
        text: messageController.text.trim(),
        images: imageUrls,
      );
      messageController.clear();
      images = [];
      dismissLoadingDialog();
    } catch (e) {
      dismissLoadingDialog();
      // _snackBarService.showSnackBar(ErrorHandler.handle(e).failure.message);
      _snackBarService.showErrorSnackBar(e.toString());
    }
  }

  void pickImages() {
    _imagesApi.pickImages().then((value) {
      images = value;
      notifyListeners();
    });
  }

  void clearImages() {
    images = [];
    notifyListeners();
  }
}
