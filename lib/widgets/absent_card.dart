
import 'package:attendenz/models/subjectCategory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsentCard extends StatelessWidget {
  final String reason;
  final DateTime date;
  final String medical;
  final Subjectcategory category;
  final DateTime time;
  const AbsentCard({
    super.key,
    required this.reason,
    required this.date,
    required this.medical,
    required this.category,
    required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20
      ),
      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 1)
          ),
        ]
      ),

      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: SubjectcategoryColors[category]?.withOpacity(0.2)!,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(
              SubjectcategoryIcons[category]!,
              size: 35,
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(category.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
              ),

              SizedBox(
                width: 150,
                child: Text(reason,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
                ),
                overflow: TextOverflow.ellipsis,
                ),
              ),
              
            ],
          ),

          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(DateFormat.yMMMd().format(date),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
              ),

              Text(DateFormat.jm().format(time),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey
              ),
              ),
              
            ],
          )
        ],
      ),
    );
  }
}