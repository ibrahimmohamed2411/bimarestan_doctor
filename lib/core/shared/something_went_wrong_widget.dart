import 'package:flutter/material.dart';

class SomethingWentWrongWidget extends StatelessWidget {
  const SomethingWentWrongWidget({Key? key, required this.onTap})
      : super(key: key);
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Icon(Icons.replay_outlined),
          SizedBox(height: 4),
          Align(
              alignment: Alignment.center,
              child: Text(
                'Something went wrong',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}