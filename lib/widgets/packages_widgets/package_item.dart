import 'dart:math';

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:thefitness1gym/global/color_extension.dart';
import 'package:thefitness1gym/global/duration_extension.dart';
import 'package:thefitness1gym/global/widgets/animated_tap.dart';
import 'package:thefitness1gym/models/subscription_package.dart';
import 'package:thefitness1gym/values/predefined_padding.dart';
import 'package:thefitness1gym/values/predefined_radius.dart';

class PackageItem extends StatelessWidget {
  const PackageItem({
    super.key,
    this.highlight = false,
    required this.package,
  });

  final bool highlight;
  final SubscriptionPackage package;

  String format(double value) {
    return NumberFormat.currency(
      customPattern: "#,###.##",
      locale: "en_US",
      symbol: package.currency,
      decimalDigits: value % 1 == 0 ? 0 : 2,
    ).format(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const pad = SizedBox(height: PredefinedPadding.regular);

    final borderRadius = BorderRadius.circular(PredefinedRadius.medium);

    final bg = highlight ? theme.colorScheme.primary : theme.colorScheme.surface;

    final bgDiscount = bg.withLightness(highlight ? .15 : .25);
    final fgDiscount = highlight ? bg : bg.withLightness(.9);

    final fgFocus = highlight ? bgDiscount : theme.colorScheme.secondary;
    final fg = fgFocus.withOpacity(.75);

    return AnimatedTap(
      useInkWell: true,
      inkWellBorderRadius: borderRadius,
      inkWellColor: highlight ? bg : fg,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        color: bg,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            children: [
              if (package.discount != null)
                Positioned(
                  left: -PredefinedPadding.yomama,
                  top: -PredefinedPadding.largeXX / 2,
                  child: Transform.rotate(
                    angle: -pi / 4,
                    child: Container(
                      color: bgDiscount,
                      padding: const EdgeInsets.only(
                        top: PredefinedPadding.huge,
                        bottom: PredefinedPadding.regular,
                        left: PredefinedPadding.yomama,
                        right: PredefinedPadding.yomama,
                      ),
                      child: Text(
                        "-${format(package.discount!.value)}%",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: fgDiscount,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(PredefinedPadding.medium),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            package.duration.format(),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: fg,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: format(package.price),
                                  style: theme.textTheme.displayMedium?.copyWith(
                                    color: fgFocus,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: " ${package.currency}",
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    color: fgFocus,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pad,
                          Text(
                            "Perks:",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: fg,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (package.perks != null)
                            for (final perk in package.perks!)
                              Text(
                                "• $perk •",
                                style: theme.textTheme.bodyMedium?.copyWith(color: fg),
                              ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (package.discount != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.clock, color: fg, size: 18),
                              const SizedBox(width: PredefinedPadding.regular),
                              Text(
                                "Discount ends in ${DateTimeFormat.relative(
                                  package.discount!.end,
                                  levelOfPrecision: 1,
                                  abbr: true,
                                  appendIfAfter: "ago",
                                )}",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: fg,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        pad,
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: bgDiscount,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: PredefinedPadding.large, vertical: PredefinedPadding.medium),
                          child: Text(
                            "JOIN NOW",
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: fgDiscount,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}