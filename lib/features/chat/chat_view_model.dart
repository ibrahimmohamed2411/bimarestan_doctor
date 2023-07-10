import 'dart:async';
import 'dart:io';

import '../../core/services/snack_bar_service.dart';
import '../../core/state_management/view_state.dart';
import '../../core/utils/dialogs.dart';
import '../../locator/locator.dart';
import 'data/chat_api.dart';
import 'data/images_api.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'models/message.dart';

@injectable
class ChatViewModel extends ChangeNotifier {
  final ChatAPI _api = ChatAPI();
  final ImagesApi _imagesApi = ImagesApi();
  final SnackBarService _snackBarService = locator<SnackBarService>();

  Stream<List<Message>> emptyStream = Stream.value([]);
  late Stream<List<Message>> messagesStream;
  String? conversationId;

  final TextEditingController messageController = TextEditingController();

  late int doctorId;
  late String doctorName;
  late int patientId;
  late String patientName;

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
      final conversation = await _api.getConversation(
        doctorId: doctorId,
        patientId: patientId,
      );
      if (conversation != null) {
        conversationId = conversation.id;
        messagesStream = _api.getMessagesStream(conversationId!);
      }
      viewState = ViewState.success;
      notifyListeners();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
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

      final message = await _api.sendMessage(
        conversationId: conversationId,
        senderId: patientId,
        senderName: patientName,
        recieverId: doctorId,
        recieverName: doctorName,
        text: messageController.text.trim(),
        images: imageUrls,
      );
      messageController.clear();
      images = [];
      if (conversationId == null) {
        conversationId = message.conversationId;
        messagesStream = _api.getMessagesStream(conversationId!);
        notifyListeners();
      }
      dismissLoadingDialog();
    } catch (e) {
      dismissLoadingDialog();
      _snackBarService.showSuccessSnackBar(
        'something went wrong',
      );
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
