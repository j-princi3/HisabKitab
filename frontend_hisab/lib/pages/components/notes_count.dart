import 'package:flutter/material.dart';

class NotesCount extends StatelessWidget {
  const NotesCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure the column takes minimal space
      children: [
        // Header Box
        Container(
          width: 174,
          height: 47,
          decoration: BoxDecoration(
            color: const Color(0xFFD4E7C5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'Notes',
              style: TextStyle(
                color: Color(0xFF6FA94E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Container(
              width: 176,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD4E7C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                maxLength: 7,
                style: TextStyle(
                  color: Color(0xFF6FA94E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right, // Align text to the right
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "500",
                  hintStyle: TextStyle(
                    color: Color(0xFF6FA94E), // Set hint text color
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  counterText: "", // Remove character counter
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 176,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD4E7C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                maxLength: 7,
                style: TextStyle(
                  color: Color(0xFF6FA94E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right, // Align text to the right
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "200",
                  hintStyle: TextStyle(
                    color: Color(0xFF6FA94E), // Set hint text color
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  counterText: "", // Remove character counter
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 176,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFD4E7C5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                keyboardType: TextInputType.number,
                maxLength: 7,
                style: TextStyle(
                  color: Color(0xFF6FA94E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right, // Align text to the right
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "100",
                  hintStyle: TextStyle(
                    color: Color(0xFF6FA94E), // Set hint text color
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                  counterText: "", // Remove character counter
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 3,vertical: 4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
