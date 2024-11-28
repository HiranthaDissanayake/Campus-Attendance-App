import 'package:flutter/material.dart';

// subject category
enum Subjectcategory {
  subject1,
  subject2,
  subject3,
  subject4,
  subject5
}

// category icons
final Map<Subjectcategory, IconData> SubjectcategoryIcons = {
  Subjectcategory.subject1: Icons.analytics_rounded,
  Subjectcategory.subject2: Icons.yard_rounded,
  Subjectcategory.subject3: Icons.wallet_membership_rounded,
  Subjectcategory.subject4: Icons.menu_book_rounded,
  Subjectcategory.subject5: Icons.text_snippet
};

// category colors
final Map<Subjectcategory, Color> SubjectcategoryColors={
  Subjectcategory.subject1: const Color.fromARGB(255, 122, 111, 10),
  Subjectcategory.subject2: const Color.fromARGB(255, 3, 134, 114),
  Subjectcategory.subject3: const Color.fromARGB(255, 158, 11, 124),
  Subjectcategory.subject4: const Color.fromARGB(255, 190, 7, 56),
  Subjectcategory.subject5: const Color.fromARGB(255, 80, 155, 5),
};

class Subject{
  final int id;
  final String title;
  final DateTime date;
  final Subjectcategory category;
  final DateTime time;
  final String reason;
  final String medical;

  Subject({
    required this.id,
    required this.title,
    required this.date,
    required this.category,
    required this.time,
    required this.reason,
    required this.medical
    });
} 