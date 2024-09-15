import 'package:flutter/material.dart';

class CustomQuickTextFieldWithHeader extends StatelessWidget {
  final String headerText;
  final List<String> quickAmount;
  final Function(String) onAmountSelected; // Function to handle amount selection

  const CustomQuickTextFieldWithHeader({
    Key? key,
    required this.headerText,
    required this.quickAmount,
    required this.onAmountSelected, // Pass the function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: quickAmount.map((amount) {
                  return GestureDetector( // Wrap each item with GestureDetector
                    onTap: () {
                      onAmountSelected(amount); // Call the function
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      constraints: BoxConstraints(
                        minWidth: 50,
                        maxWidth: 200, // Set a maximum width as per your requirement
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color: Colors.black26),
                      ),
                      child: Text(
                        amount,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

