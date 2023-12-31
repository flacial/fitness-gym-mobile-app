import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:phone_number/phone_number.dart';
import 'package:thefitness1gym/global/color_extension.dart';
import 'package:thefitness1gym/global/models/map_coordinates.dart';
import 'package:thefitness1gym/pages/coaches_page.dart';
import 'package:thefitness1gym/values/predefined_padding.dart';
import 'package:thefitness1gym/values/predefined_radius.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    required this.title,
    required this.description,
    required this.location,
    this.isOpen = false,
    this.hasLadiesSection = false,
    required this.coordinates,
    required this.phone,
    this.image,
    super.key,
  });

  final String title;
  final String description;
  final String location;
  final bool isOpen;
  final bool hasLadiesSection;
  final MapCoordinates coordinates;
  final PhoneNumber phone;
  final Uri? image;

  Uri get _tel => Uri.parse("tel:${phone.international}");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const borderRadius = BorderRadius.all(Radius.circular(PredefinedRadius.medium));
    const topBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(PredefinedRadius.medium),
      topRight: Radius.circular(PredefinedRadius.medium),
    );

    outlinedButtonStyle<Widget>() {
      return ButtonStyle(
        side: MaterialStatePropertyAll(
          BorderSide(color: theme.colorScheme.onSurface),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(PredefinedRadius.regular),
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(theme.colorScheme.onSurface),
      );
    }

    return Card(
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: borderRadius,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.background.withOpacity(.5),
                      blurRadius: 50,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: topBorderRadius,
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    child: Image.network(
                      image.toString(),
                      fit: BoxFit.cover,
                      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                        if (wasSynchronouslyLoaded) return child;
                        return AnimatedOpacity(
                          opacity: frame == null ? 0 : 1,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeOut,
                          child: child,
                        );
                      },
                      loadingBuilder: (context, widget, imageChunkEvent) {
                        if (imageChunkEvent != null) return widget;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          "assets/images/fitness1_cover.jpg",
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) return child;
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(PredefinedPadding.regular),
                child: BlurryContainer(
                  borderRadius: borderRadius,
                  blur: 2,
                  padding: const EdgeInsets.symmetric(horizontal: PredefinedPadding.medium, vertical: PredefinedPadding.small),
                  color: (isOpen ? theme.colorScheme.primary : theme.colorScheme.error).withOpacity(.68).withSaturation(.5).withBrightness(.15),
                  child: Text(
                    isOpen ? "OPEN" : "CLOSED",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: (isOpen ? theme.colorScheme.primary : theme.colorScheme.error).withBrightness(.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PredefinedPadding.medium,
              vertical: PredefinedPadding.regular,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: "branchTitle_$title",
                          child: Text(
                            title,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          " — $location",
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    if (hasLadiesSection)
                      Text(
                        'Ladies section',
                        style: TextStyle(color: Colors.pink.shade200, fontWeight: FontWeight.w700),
                      )
                  ],
                ),
                const SizedBox(height: PredefinedPadding.medium),
                Text(description),
                const SizedBox(height: PredefinedPadding.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          if (await canLaunchUrl(_tel)) await launchUrl(_tel);
                        },
                        icon: const Icon(FontAwesomeIcons.phone, size: 14),
                        label: const Text("Contact", style: TextStyle(fontWeight: FontWeight.w600)),
                        style: outlinedButtonStyle(),
                      ),
                    ),
                    const SizedBox(width: PredefinedPadding.regular),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.clock, size: 14),
                        label: const Text("Working hours", style: TextStyle(fontWeight: FontWeight.w600)),
                        style: outlinedButtonStyle(),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => MapsLauncher.launchCoordinates(coordinates.latitude, coordinates.longitude),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(PredefinedRadius.regular),
                    ),
                    padding: const EdgeInsets.all(PredefinedPadding.regular),
                    textStyle: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  child: const Text("View location"),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).push(CoachesPage.route(title)),
                    child: const Text("Coaches in this branch", style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
