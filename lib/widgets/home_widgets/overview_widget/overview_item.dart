import 'package:flutter/material.dart';
import 'package:thefitness1gym/values/predefined_padding.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem({
    super.key,
    required this.textBig,
    required this.text,
    this.color,
    this.backgroundColor,
    this.icon,
    this.padding,
  });

  final String? textBig;
  final String text;
  final Color? color;
  final Color? backgroundColor;
  final IconData? icon;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = this.color ?? theme.colorScheme.onBackground;
    final backgroundColor = this.backgroundColor ?? theme.colorScheme.background;

    final children = <Widget>[];
    if (icon != null) {
      children.add(Icon(icon, color: color, size: 20));
      var spaceWidth = PredefinedPadding.regular;
      if (padding != null) spaceWidth = padding!.horizontal / 2;
      children.add(SizedBox(width: spaceWidth));
    }
    children.add(
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$textBig ',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 20,
                color: color,
                fontWeight: FontWeight.bold,
                letterSpacing: -.5,
              ),
            ),
            TextSpan(
              text: text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      padding: padding,
      color: backgroundColor,
      // width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
