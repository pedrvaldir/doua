import 'package:doua/model/doua_acao.dart';
import 'package:doua_uikit/doua_uikit.dart';
import 'package:flutter/material.dart';

class DouaListCard extends StatelessWidget {
  String? title;
  List<DouaAcao> list;

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

  Widget _buildWidget(DouaAcao item) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 100,
            child: Center(child: DouaImage(base64: item.urlImg)),
          ),
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(item.titulo!),
          ),
        ],
      ),
    );
  }
}
