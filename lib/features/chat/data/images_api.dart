import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImagesApi {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<List<File>> pickImages() async {
    final List<File> images = [];
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      for (final image in pickedImages) {
        images.add(File(image.path));
      }
    }
    return images;
  }

  // keep file names unique and keep file type
  Future<List<String>> uploadImages(List<File> images) async {
    final List<String> imageUrls = [];

    for (final image in images) {
      final String fileName = DateTime.now().toString();
      final String fileType = image.path.split('.').last;
      final String path = 'images/$fileName.$fileType';
      final Reference ref = _storage.ref().child(path);
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String url = await taskSnapshot.ref.getDownloadURL();
      imageUrls.add(url);
    }
    return imageUrls;
  }
}
