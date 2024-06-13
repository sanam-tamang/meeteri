import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class QuotesPage extends StatelessWidget {
  final List<String> quotes = [
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "The future belongs to those who believe in the beauty of their dreams. - Eleanor Roosevelt",
    "Hardships often prepare ordinary people for an extraordinary destiny. - C.S. Lewis",
    "Your limitation—it's only your imagination.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Dream it. Wish it. Do it.",
    "Success doesn’t just find you. You have to go out and get it."
  ];

  QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      color: Colors.grey.shade300,
      child: PageView.builder(
        itemCount: quotes.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Card(
              color: Colors.black87,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: '"', style: TextStyle(fontSize: 45)),
                      TextSpan(
                        text: quotes[index],
                      ),
                      const TextSpan(text: '"', style: TextStyle(fontSize: 45)),
                    ],
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
