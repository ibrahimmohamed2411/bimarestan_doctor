
import 'package:flutter/material.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({Key? key, required this.onTap})
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
              child: Text('No Internet Connection'))
        ],
      ),
    );
  }
}
