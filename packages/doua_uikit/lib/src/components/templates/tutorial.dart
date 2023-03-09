import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../../../doua_uikit.dart';
import '../../shared/doua_sizes.dart';

class TutorialSteps {
  late Uint8List imageBase64;
  late Image image;
  late String title;
  late String description;

  TutorialSteps(
      {required this.imageBase64,
      required this.title,
      required this.description});

  TutorialSteps.fromMap(Map<dynamic, dynamic> map) {
    image = Image.network(map['icon']);
    title = map['titulo'];
    description = map['descricao'];
  }
}

class DouaTutorial {
  final Key? key;
  final List<TutorialSteps> steps;
  final bool showDouaButtonText;
  final String nextButtonText;
  final String primaryButtonText;
  final VoidCallback? primaryAction;
  final String secundatyButtonText;
  final VoidCallback? secundaryAction;

  const DouaTutorial(
      {Key? key,
      this.nextButtonText = "PRÓXIMO",
      this.showDouaButtonText = true,
      required this.steps,
      required this.primaryButtonText,
      this.primaryAction,
      this.secundatyButtonText = "PULAR",
      this.secundaryAction})
      : this.key = key;

  void show(BuildContext context) {
    _BasisDouaTutorial tutorial = _buildTutorial();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => tutorial));
  }

  _BasisDouaTutorial _buildTutorial() {
    return _BasisDouaTutorial(
      key: this.key,
      nextButtonText: this.nextButtonText,
      showDouaButtonText: this.showDouaButtonText,
      steps: this.steps,
      primaryButtonText: this.primaryButtonText.toUpperCase(),
      primaryAction: this.primaryAction,
      secundaryButtonText: this.secundatyButtonText,
      secundaryAction: this.secundaryAction,
    );
  }
}

class _BasisDouaTutorial extends StatefulWidget {
  final List<TutorialSteps> steps;
  final bool? showDouaButtonText;
  final String? nextButtonText;
  final String? primaryButtonText;
  final VoidCallback? primaryAction;
  final String? secundaryButtonText;
  final VoidCallback? secundaryAction;

  const _BasisDouaTutorial(
      {Key? key,
      this.nextButtonText = "PRÓXIMO",
      this.showDouaButtonText = true,
      required this.steps,
      this.primaryButtonText,
      this.primaryAction,
      this.secundaryButtonText = "PULAR",
      this.secundaryAction})
      : assert(steps.length != 0, "Empty list on DouaTutorial"),
        super(key: key);
  @override
  _BasisDouaTutorialState createState() => _BasisDouaTutorialState();
}

class _BasisDouaTutorialState extends State<_BasisDouaTutorial> {
  PageController _controller = PageController();

  double pageOffset = 0.0;
  double lastPageOffSet = 0.0;
  int page = 0;
  bool atLastPage = false;

  @override
  void initState() {
    _controller.addListener(() {
      setState(() {
        pageOffset = _controller.offset;
        lastPageOffSet = ((1.0 - (widget.steps.length - _controller.page!)) + 1)
            .clamp(0.0, 1.0);
        page = _controller.page!.round();
        atLastPage = page == widget.steps.length - 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: DouaSizes.spacing4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _startWidgets(),
              _scrollingElements(),
              _endWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  _startWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => widget.primaryAction!(),
          child: Container(
              padding: EdgeInsets.all(DouaSizes.spacing20),
              child: Icon(Icons.close)),
        )
      ],
    );
  }

  _scrollingElements() {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Container(
                child: PageView(
          controller: _controller,
          physics: BouncingScrollPhysics(),
          children: _tutorialPageBuilder(),
        )))
      ],
    ));
  }

  Widget _endWidgets() {
    return Column(children: [
      _dots(),
      _buttons(),
    ]);
  }

  _dots() {
    return Container(
      height: DouaSizes.spacing32,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.steps.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: DouaSizes.spacing8),
              child: Container(
                height: DouaSizes.spacing8,
                width: DouaSizes.spacing8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: page == index
                      ? DouaPallet.kcPrimaryColor
                      : DouaPallet.kcMediumGreyColor,
                ),
              ),
            );
          })),
    );
  }

  _buttons() {
    return Container(
      padding: EdgeInsets.all(DouaSizes.spacing24),
      child: Row(
        children: [
          widget.showDouaButtonText! && !atLastPage
              ? Expanded(child: _secundaryButton())
              : Container(),
          SizedBox(
            width: DouaSizes.spacing4,
          ),
          widget.showDouaButtonText! && !atLastPage
              ? Expanded(child: _nextButton())
              : Expanded(child: _primaryButton()),
        ],
      ),
    );
  }

  List<Widget> _tutorialPageBuilder() {
    return widget.steps.map((step) {
      double screenSize = MediaQuery.of(context).size.width;
      int index = widget.steps.indexOf(step) + 1;
      double iconPosition = screenSize * (index - 1);

      double scrollOffsetForItem = iconPosition - pageOffset;

      Widget _transformOnXAxisBy(Widget child, double val) {
        return Transform.translate(
          offset: Offset(scrollOffsetForItem / val, 0.0),
          child: child,
        );
      }

      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _transformOnXAxisBy(
                Padding(
                  padding: EdgeInsets.symmetric(vertical: DouaSizes.spacing4),
                  child: DouaText.caption(step.title),
                ),
                2.0),
            _transformOnXAxisBy(
                Padding(
                  padding: EdgeInsets.all(DouaSizes.spacing24),
                  child: Container(height: 150, child: step.image),
                ),
                2.0),
            SizedBox(
              height: DouaSizes.spacing24,
            ),
            SizedBox(
              height: DouaSizes.spacing4,
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DouaSizes.spacing20,
              ),
              child: DouaText.body(step.description),
            )),
          ],
        ),
      );
    }).toList();
  }

  _primaryButton() {
    return DouaButton(
      title: atLastPage ? widget.primaryButtonText! : "Próximo",
      onClick: widget.secundaryAction ?? widget.primaryAction!,
    );
  }

  _secundaryButton() {
    return DouaButton.outline(
        title: widget.secundaryButtonText,
        onClick: () => _controller.animateToPage(page + widget.steps.length - 1,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn));
  }

  _nextButton() {
    return DouaButton(
        title: widget.nextButtonText!,
        onClick: atLastPage
            ? widget.primaryAction!
            : () => _controller.animateToPage(page + 1,
                duration: Duration(milliseconds: 200), curve: Curves.easeIn));
  }
}
