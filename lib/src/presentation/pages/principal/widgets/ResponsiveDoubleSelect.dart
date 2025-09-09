import 'package:flutter/material.dart';

class ResponsiveDoubleSelect extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final List<String> firstOptions;
  final List<String> secondOptions;
  final String? firstSelected;
  final String? secondSelected;
  final ValueChanged<String?> onFirstChanged;
  final ValueChanged<String?> onSecondChanged;

  const ResponsiveDoubleSelect({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
    required this.firstOptions,
    required this.secondOptions,
    required this.firstSelected,
    required this.secondSelected,
    required this.onFirstChanged,
    required this.onSecondChanged,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Primer Select
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(firstLabel, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: firstSelected,
                  underline: const SizedBox(),
                  items: firstOptions
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: onFirstChanged,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: size.width * 0.04),

        // Segundo Select
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(secondLabel, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: secondSelected,
                  underline: const SizedBox(),
                  items: secondOptions
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: onSecondChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
