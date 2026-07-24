import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class PredictionCard extends StatelessWidget {
  final String? prediction;

  const PredictionCard({super.key, required this.prediction});

  @override
  Widget build(BuildContext context) {
    final bool hasPrediction = prediction != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.timer_outlined,
            color: hasPrediction ? AppColors.success : AppColors.primary,
            size: 50,
          ),

          const SizedBox(height: 15),

          const Text(
            "Predicted Response Time",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: hasPrediction
                ? Text(
                    "$prediction minutes",
                    key: const ValueKey("prediction"),
                    style: const TextStyle(
                      fontSize: 34,
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    "Waiting for prediction...",
                    key: ValueKey("waiting"),
                    style: TextStyle(fontSize: 18, color: AppColors.subtitle),
                  ),
          ),
        ],
      ),
    );
  }
}
