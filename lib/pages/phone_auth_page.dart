import 'package:flutter/material.dart';
import 'package:thefitness1gym/assets/values/predefined_padding.dart';
import 'package:thefitness1gym/assets/values/predefined_radius.dart';

class PhoneNumberAuthScreen extends StatelessWidget {
  PhoneNumberAuthScreen({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: const BackButton(),
          title: const Text("Signup"),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(PredefinedPadding.big),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: PredefinedPadding.xLarge, vertical: PredefinedPadding.medium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(PredefinedRadius.regular),
                    color: Colors.white12,
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(PredefinedRadius.regular),
                        child: TextFormField(
                          controller: myController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Enter your phone number',
                            filled: true,
                            fillColor: Colors.white10,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: PredefinedPadding.medium),
                      ElevatedButton(
                        onPressed: () {
                          print(myController.text);
                          // Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OtpVerificationPage()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.amber),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(PredefinedRadius.regular),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all(Size.fromHeight(50)),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}