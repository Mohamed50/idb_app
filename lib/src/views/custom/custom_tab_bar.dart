import 'package:az_banking_app/src/config/colors.dart';
import 'package:flutter/material.dart';
import 'customs.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> labels;
  final ValueChanged<int> onTap;
  final int selectedIndex;
  final double sizePercentage;
  final double fontSize;

  const CustomTabBar({super.key, required this.labels, required this.onTap, required this.selectedIndex, this.sizePercentage = 0.94, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: LayoutBuilder(builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            labels.length,
            (index) => InkWell(
                onTap: () => onTap(index),
                child: TabWidget(
                  fontSize: fontSize,
                  text: labels[index],
                  selected: selectedIndex == index,
                  width: (constraints.maxWidth / labels.length) * sizePercentage,
                )),
          ),
        );
      }),
    );
  }
}

class TabWidget extends StatelessWidget {
  final double width;
  final double fontSize;
  final String text;
  final bool selected;

  const TabWidget({super.key, required this.text, required this.width, required this.selected, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    Color color = selected ? ColorManager.primaryColor : ColorManager.darkBackgroundColor;
    Color borderColor = selected ? ColorManager.primaryColor : Colors.white;
    Color textColor = selected ? ColorManager.lightBackgroundColor : ColorManager.titleColor;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.0), border: Border.all(color: borderColor)),
      child: CustomText(
        text,
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
