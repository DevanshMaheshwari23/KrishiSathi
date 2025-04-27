import 'package:flutter/material.dart';
import 'package:krishi_sathi/pages/predictionpage.dart';

class RoundedBox extends StatelessWidget {
  const RoundedBox({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              offset: const Offset(16, 16),
              blurRadius: 40,
            ),
          ],
          border: Border.all(
            width: 1,
            color: AppColors.primaryGreen,
          ),
          borderRadius: BorderRadius.circular(11)),
      child: child,
    );
  }
}
