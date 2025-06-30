import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jing_hong_v4/ui/auth/auth_viewmodel.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;

class AddAvatar extends StatefulWidget {
  final AuthViewmodel viewmodel;

  const AddAvatar({super.key, required this.viewmodel});

  @override
  State<AddAvatar> createState() => _AddAvatarState();
}

class _AddAvatarState extends State<AddAvatar> {
  final picker = ImagePicker();
  File? _selectedImage;
  XFile? _originImage;
  bool isUpdating = false;
  String? msg;

  Future<void> _pickImage() async {
    _originImage = await picker.pickImage(source: ImageSource.gallery);
    if (_originImage != null) {
      setState(() {
        msg = null;
        _selectedImage = File(_originImage!.path);
      });
    }
  }

  void _reset() {
    setState(() {
      msg = null;
      _selectedImage = null;
    });
  }

  Future<void> _uploadAvatar() async {
    if (_originImage == null) {
      setState(() {
        msg = "未上传文件";
      });
    }

    final rst = await widget.viewmodel.setAvatar(_originImage!);

    rst.when(
      success: (data) {
        context.pop(true);
      },
      failure: (msg, err) {
        setState(() {
          msg = msg;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      
      Center(
        child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400,maxHeight: 400),
          child: Card(
            color: AppColors.active,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: _pickImage,
                        child: Center(
                          child:
                              _selectedImage == null
                                  ? Text(
                                    "请选择图片",
                                    style: Theme.of(context).textTheme.displayLarge,
                                  )
                                  : _buildImage(),
                        ),
                      ),
                    ),
                    if (msg != null) Text(msg!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(onPressed: _reset, child: Text("重置")),
                        TextButton(onPressed: _uploadAvatar, child: Text("确认")),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
     );
  }

  Widget _buildImage() {
    return kIsWeb? Image.network(_selectedImage!.path):Image.file(_selectedImage!);
  }
}
