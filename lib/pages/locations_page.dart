import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:thefitness1gym/assets/values/predefined_padding.dart';
import 'package:thefitness1gym/global/map_coordinates.dart';
import 'package:thefitness1gym/widgets/locations_widgets/location_card.dart';
import 'package:thefitness1gym/widgets/page_title.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(builder: (context) => const LocationsPage());

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const spacer = SizedBox(height: PredefinedPadding.regular);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const PageTitle("Gym Locations"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.background,
      ),
      body: ListView(
        padding: const EdgeInsets.all(PredefinedPadding.regular),
        children: const [
          LocationCard(
            title: "Fitness 1 Gym",
            description:
                "Fitness 1 Gym is a gym located in the heart of the city. We offer a wide range of services and equipment to help you achieve your fitness goals.",
            location: "1234 Street 1, City 54, Mars",
            isOpen: true,
            coordinates: MapCoordinates(latitude: 0, longitude: 0),
            phone: PhoneNumber(
              e164: "+14175555470",
              type: PhoneNumberType.FIXED_LINE_OR_MOBILE,
              international: "+1 417-555-5470",
              national: "(417) 555-5470",
              countryCode: "1",
              regionCode: "US",
              nationalNumber: "4175555470",
            ),
          ),
          spacer,
          LocationCard(
            title: "Fitness 1 Gym",
            description:
                "Fitness 1 Gym is a gym located in the heart of the city. We offer a wide range of services and equipment to help you achieve your fitness goals.",
            location: "1234 Street 1, City 54, Mars",
            isOpen: false,
            coordinates: MapCoordinates(latitude: 0, longitude: 0),
            phone: PhoneNumber(
              e164: "+14175555470",
              type: PhoneNumberType.FIXED_LINE_OR_MOBILE,
              international: "+1 417-555-5470",
              national: "(417) 555-5470",
              countryCode: "1",
              regionCode: "US",
              nationalNumber: "4175555470",
            ),
          ),
          spacer,
          LocationCard(
            title: "Fitness 1 Gym",
            description:
                "Fitness 1 Gym is a gym located in the heart of the city. We offer a wide range of services and equipment to help you achieve your fitness goals.",
            location: "1234 Street 1, City 54, Mars",
            isOpen: true,
            coordinates: MapCoordinates(latitude: 0, longitude: 0),
            phone: PhoneNumber(
              e164: "+14175555470",
              type: PhoneNumberType.FIXED_LINE_OR_MOBILE,
              international: "+1 417-555-5470",
              national: "(417) 555-5470",
              countryCode: "1",
              regionCode: "US",
              nationalNumber: "4175555470",
            ),
          ),
        ],
      ),
    );
  }
}