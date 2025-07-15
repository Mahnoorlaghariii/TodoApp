import 'package:flutter/material.dart';
import 'package:todolist/utils/dummy_quotes.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final VoidCallback onClose;
  QuoteCard({super.key, required this.onClose})
    : quote = (Dummyquotes..shuffle()).first;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "/ $quote /",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 20, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
