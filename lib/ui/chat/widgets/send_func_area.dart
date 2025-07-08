import 'package:flutter/material.dart';
import 'package:jing_hong_v4/data/data/chat/local/basic_info.dart';
import 'package:jing_hong_v4/ui/chat/view_models/message_viewmodel.dart';

class SendFuncArea extends StatefulWidget {
  final double height;
  final double width;
  final Function(String) onSend;
  final VoidCallback closePanel;
  final MessageViewmodel viewmodel;

  const SendFuncArea({
    super.key,
    required this.height,
    required this.width,
    required this.onSend,
    required this.viewmodel, required this.closePanel,
  });

  @override
  State<SendFuncArea> createState() => _SendFuncAreaState();
}

class _SendFuncAreaState extends State<SendFuncArea> {
  final TextEditingController controller = TextEditingController();

  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sendMessage(String msg) {
    if (msg.isNotEmpty) {
      widget.onSend(msg);
    }
    controller.clear();
  }

  bool getEnableState() {
    return widget.viewmodel.cachedMessage?.state != MsState.running &&
        widget.viewmodel.cachedMessage?.state != MsState.ready;
  }

  @override
  Widget build(Object context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(widget.height)),
      ),
      child: Row(
        children: [
          IconButton(onPressed: null, icon: Icon(Icons.mic_outlined)),
          Expanded(
            child: ListenableBuilder(
              listenable: widget.viewmodel,
              builder: (context, child) {
                return  Material(
                    type: MaterialType.transparency,
                    child: TextField(
                      controller: controller,
                      onTap: widget.closePanel,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "输入消息和我对话吧！😊",
                      ),
                      readOnly: !getEnableState(),
                      onSubmitted: (value) => {_sendMessage(value)},
                      onChanged: (v) {
                        setState(() {
                          if (v.isEmpty) {
                            isEnabled = false;
                          } else {
                            isEnabled = true;
                          }
                        });
                      },
                      cursorColor: Colors.grey,
                    ),
                  );
              },
            ),
          ),
          IconButton(
            onPressed:
                isEnabled
                    ? () {
                      widget.closePanel();
                      _sendMessage(controller.text);
                    }
                    : null,
            icon: Icon(Icons.send_outlined),
          ),
        ],
      ),
    );
  }
}
