import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/image_picker_bottom_sheet.dart';

Future<ImageSource?> showImageBottomSheet(BuildContext context) {
  return showModalBottomSheet<ImageSource?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(8),
      ),
    ),
    builder: (context) => const ImagePickerBottomSheet(),
  );
}
