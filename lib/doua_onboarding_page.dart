import 'package:flutter/material.dart';
import 'package:doua_uikit/doua_uikit.dart';

class DouaOnboading extends DouaTutorial {
  DouaOnboading(BuildContext context)
      : super(
            steps: [
              TutorialSteps(
                  icon: Icon(Icons.ac_unit),
                  title: "title",
                  description: "description"),
              TutorialSteps(
                  icon: Icon(Icons.ac_unit),
                  title: "title 2",
                  description: "description"),
              TutorialSteps(
                icon: Icon(Icons.ac_unit),
                title: "title 3",
                description: "description",
              ),
              TutorialSteps(
                icon: Icon(Icons.ac_unit),
                title: "title 4",
                description: "description",
              ),
            ],
            primaryButtonText: "COMEÇAR",
            showDouaButtonText: true,
            primaryAction: () => Navigator.of(context).pop());
}
