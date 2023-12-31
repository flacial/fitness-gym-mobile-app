import 'package:flutter/material.dart';
import 'package:thefitness1gym/global/color_extension.dart';
import 'package:thefitness1gym/values/predefined_padding.dart';
import 'package:thefitness1gym/values/predefined_radius.dart';
import 'package:thefitness1gym/values/predefined_size.dart';

import '../widgets/fitness1_title.dart';
import 'otp_verify_page.dart';

@immutable
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static MaterialPageRoute get route => MaterialPageRoute(builder: (context) => const SignupPage());

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool nextEnabled = false;
  bool onPhoneNumber = false;

  final textEditingController = TextEditingController();

  Widget signIn(ThemeData theme) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() => onPhoneNumber = true);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.colorScheme.primary),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(PredefinedRadius.regular),
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(PredefinedSize.buttonHeight)),
          ),
          child: const Text(
            'Phone number',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: PredefinedPadding.medium),
        ElevatedButton.icon(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(theme.colorScheme.surface),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(PredefinedRadius.regular),
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(PredefinedSize.buttonHeight)),
          ),
          label: const Text(
            'Fingerprint ID',
            style: TextStyle(color: Colors.white38),
          ),
          icon: Icon(Icons.fingerprint, color: Colors.amber.withBrightness(0.3)),
        ),
      ],
    );
  }

  Widget phoneAuth(ThemeData theme) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(PredefinedRadius.regular),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Enter your phone number',
              border: InputBorder.none,
              filled: true,
              fillColor: theme.colorScheme.secondary.withBrightness(.1),
              contentPadding: const EdgeInsets.symmetric(
                vertical: PredefinedPadding.small,
                horizontal: PredefinedPadding.medium,
              ),
            ),
          ),
        ),
        const SizedBox(height: PredefinedPadding.medium),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(OtpVerifyPage.route);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.amber),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(PredefinedRadius.regular),
              ),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(PredefinedSize.buttonHeight)),
          ),
          child: Text(
            'Send OTP',
            style: TextStyle(color: theme.colorScheme.background, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget heading(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Fitness1Title(),
          Text(
            'Unleash Your Greatness Today!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget contentTitle(ThemeData theme) {
    final titleStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.secondary,
    );

    const duration = Duration(milliseconds: 350);

    final backButton = BackButton(
      onPressed: () {
        setState(() => onPhoneNumber = false);
        textEditingController.text = '';
      },
    );

    return SizedBox(
      height: PredefinedSize.toolbarHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCrossFade(
            crossFadeState: onPhoneNumber ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: duration,
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeOut,
            firstChild: const SizedBox(width: PredefinedPadding.medium),
            secondChild: backButton,
          ),
          AnimatedCrossFade(
            crossFadeState: onPhoneNumber ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: duration,
            firstCurve: Curves.easeOut,
            secondCurve: Curves.easeOut,
            firstChild: Text("Sign in", style: titleStyle),
            secondChild: Text("Verify phone", style: titleStyle),
          ),
        ],
      ),
    );
  }

  Widget content(ThemeData theme) {
    const duration = Duration(milliseconds: 200);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        contentTitle(theme),
        const SizedBox(height: PredefinedPadding.regular),
        AnimatedSize(
          duration: duration,
          curve: Curves.ease,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: PredefinedPadding.regular, horizontal: PredefinedPadding.medium),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PredefinedRadius.medium),
              color: theme.colorScheme.surface.withOpacity(.75),
            ),
            width: double.infinity,
            child: AnimatedCrossFade(
              duration: duration,
              firstChild: signIn(theme),
              secondChild: phoneAuth(theme),
              crossFadeState: onPhoneNumber ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Opacity(
              opacity: .6,
              child: Image.asset(
                'assets/images/hot_man.png',
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
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [heading(context), content(theme)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
