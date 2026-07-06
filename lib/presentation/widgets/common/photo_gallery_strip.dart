import 'package:flutter/material.dart';

class PhotoGalleryStrip extends StatelessWidget {
  final List<String> photoUrls;

  const PhotoGalleryStrip({Key? key, required this.photoUrls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (photoUrls.isEmpty) {
      return Container(
        height: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Sin galería disponible', style: TextStyle(color: Colors.grey)),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photoUrls.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              photoUrls[index],
              width: 160,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 160,
                height: 120,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}
