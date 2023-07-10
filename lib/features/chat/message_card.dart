import 'package:flutter/material.dart';

import '../../core/utils/extensions.dart';
import '../../core/utils/media_query_values.dart';
import 'images_view.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isMe,
    required this.message,
    required this.images,
    required this.createdAt,
  });
  final bool isMe;
  final String message;
  final List<String> images;
  final DateTime createdAt;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
              left: isMe ? context.width * 0.15 : 0,
              right: isMe ? 0 : context.width * 0.15,
              bottom: 16,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ? context.colorScheme.primary
                  : context.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (images.isNotEmpty)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ImagesView(
                            images: images,
                          ),
                        ),
                      );
                    },
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: context.height * 0.3,
                        maxWidth: context.width * 0.6,
                        minWidth: context.width * 0.2,
                      ),
                      // leave a space before image loading
                      child: Stack(
                        children: [
                          Image.network(
                            images.first,
                            fit: BoxFit.cover,
                          ),
                          // show image count if more than one image
                          if (images.length > 1)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '+${images.length - 1}',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                Text(
                  message,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: isMe
                        ? context.colorScheme.surface
                        : context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  createdAt.format(),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: isMe
                        ? context.colorScheme.surface
                        : context.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//method to formate DateTime to year month day hour minute
//full date format: 2021-09-09 12:00:00.000 PM AM
extension DateFormatter on DateTime {
  String format() {
    final period = hour >= 12 ? 'PM' : 'AM';
    final periodHour = hour > 12 ? hour - 12 : hour;
    return '$year-$month-$day $periodHour:$minute $period';
  }
}
