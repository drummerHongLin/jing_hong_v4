import 'dart:math';

import 'package:flutter/material.dart' ;
import 'package:flutter_svg/svg.dart';
import 'package:jing_hong_v4/data/data/chat/local/chat_model.dart';
import 'package:jing_hong_v4/data/model/chat/chat_model.dart';

class ModelPanel extends StatelessWidget {
  final List<ChatModel> models = chatModels;

  final Offset panelOffset;

  final Function(ChatModel) onModelTap;

  ModelPanel(
      {super.key, required this.onModelTap, required this.panelOffset});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context);
    final s = min(min(400, w.height), w.width*0.7);
    return Positioned(
        left: panelOffset.dx - s,
        top: panelOffset.dy,
        child: Container(
          width: s.toDouble(),
          height: 150 * (models.length / 3),
          alignment: Alignment.center,
          child: Card(
              color: const Color.fromARGB(255, 21, 26, 35),
              child: GridView.builder(
                itemCount: models.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => InkWell(
                  onTap: () => onModelTap(models[index]),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, spacing: 10,children: [
                   SvgPicture.asset( models[index].iconUrl,height: 40,width: 40,),
                    Text(
                      models[index].name,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ]),
                ),
              )),
        ));
  }
}
