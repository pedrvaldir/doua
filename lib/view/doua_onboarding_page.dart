import 'package:flutter/material.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:lottie/lottie.dart';

class DouaOnboading extends DouaTutorial {
  late List<TutorialSteps> list;
  DouaOnboading(BuildContext context, List<TutorialSteps> list)
      : super(
            steps: list,
            primaryButtonText: "COMEÇAR",
            showDouaButtonText: true,
            primaryAction: () => Navigator.of(context).pop());
}
