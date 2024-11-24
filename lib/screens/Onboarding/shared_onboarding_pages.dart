import 'package:flutter/material.dart';

class SharedOnboardingPages extends StatelessWidget {

  final String title;
  final String imagePath;
  final String description;


  const SharedOnboardingPages({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath,
          fit: BoxFit.cover,
          width: 200,
          ),
      
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500
            ),
          ),
      
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500
            ),
          ),
      
        ],
      ),
    );
  }
}