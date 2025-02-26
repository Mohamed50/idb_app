import 'package:az_banking_app/src/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CardDesign { one, two, three }

class BankCardBackground extends StatelessWidget {
  final Widget child;
  final CardDesign cardDesign;

  const BankCardBackground({super.key, required this.child, this.cardDesign = CardDesign.one});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          SvgPicture.asset(
            cardDesign == CardDesign.one ? AssetsManager.icCardDesignOnePath : AssetsManager.icCardDesignTwoPath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          child,
        ],
      ),
    );
  }
}
