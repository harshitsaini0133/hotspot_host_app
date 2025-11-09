import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intern_assignment/feature/experience/models/experience_model.dart';

class ExperienceStampCard extends StatelessWidget {
  final bool isSelected;
  final Experience experience;
  final VoidCallback onTap;

  const ExperienceStampCard({
    super.key,
    required this.experience,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        transform: Matrix4.identity()
          ..rotateZ(isSelected ? 0 : -0.09)
          // ignore: deprecated_member_use
          ..scale(isSelected ? 1.05 : 1.0),
        transformAlignment: Alignment.center,
        child: CachedNetworkImage(
          filterQuality: FilterQuality.high,
          imageUrl: experience.imageUrl ?? '',
          imageBuilder: (context, imageProvider) => Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
                colorFilter: !isSelected
                    ? const ColorFilter.mode(Colors.grey, BlendMode.saturation)
                    : null,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
