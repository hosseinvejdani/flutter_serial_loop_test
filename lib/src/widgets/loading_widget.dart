// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            height: 7,
            child: LinearProgressIndicator(),
          ),
          const SizedBox(height: 20),
          Text(message, style: TextStyle(fontSize: 16, color: Colors.grey[100])),
        ],
      ),
    );
  }
}
