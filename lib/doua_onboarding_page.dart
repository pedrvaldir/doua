import 'package:flutter/material.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:lottie/lottie.dart';

class DouaOnboading extends DouaTutorial {
  DouaOnboading(BuildContext context)
      : super(
            steps: [
              TutorialSteps(
                  icon: Lottie.asset('assets/lotties/welcome.json'),
                  title: "Bem vindo",
                  description: "Estamos muito felizes em ter você aqui."),
              TutorialSteps(
                  icon: Lottie.asset('assets/lotties/donor.json'),
                  title: "Nosso objetivo",
                  description:
                      "Praticar atos de bondade, ter empatia ou doar até mesmo onosso tempo."),
              TutorialSteps(
                icon: Lottie.asset('assets/lotties/location.json'),
                title: "Missão",
                description:
                    "Nos unirmos para encontrar quem ajuda e quem precisa",
              ),
              TutorialSteps(
                icon: Lottie.asset('assets/lotties/letsgo.json'),
                title: "Vamos nessa",
                description: "Conectando energias e fazendo o bem!",
              ),
            ],
            primaryButtonText: "COMEÇAR",
            showDouaButtonText: true,
            primaryAction: () => Navigator.of(context).pop());
}
