import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intern_assignment/global_widgets/curved_progress_indicator.dart';
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double progress;
  final VoidCallback? closebtn;

  const CustomAppBar({
    super.key,
    required this.progress,
    this.closebtn,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
        child: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: CurvedProgressIndicator(progress: progress),
          actions: [
            IconButton(
              onPressed: closebtn,
              icon: const Icon(Icons.close, color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
