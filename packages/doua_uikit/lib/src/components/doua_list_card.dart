import 'package:flutter/material.dart';

class DouaCard {
  final String title;
  final String? subTitle;
  final String? pathImg;

  DouaCard({required this.title, this.pathImg, this.subTitle});
}

class DouaListCard extends StatelessWidget {
  String? title;
  List<DouaCard> list;

  DouaListCard({
    Key? key,
    this.title,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _buildWidget(list[index]);
          },
        ));
  }

  Widget _buildWidget(DouaCard item) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 80,
            child: Center(
                child:
                    Image.asset(item.pathImg != null ? item.pathImg! : 'null')),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(item.title),
          ),
        ],
      ),
    );
  }
}
