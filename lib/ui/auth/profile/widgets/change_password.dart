import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/ui/auth/auth_viewmodel.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

// 独立元素不多，就在当前文件中描写

class ChangePassword extends StatefulWidget {
  final AuthViewmodel viewmodel;

  const ChangePassword({super.key, required this.viewmodel});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  String _errorMessage = "";
  bool _isLoading = false;
  int count = 60;

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_passwordConfirmController.text != _passwordController.text) {
      setState(() {
        _errorMessage = '两次密码不一致';
        _isLoading = false;
      });
    } else if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final rst = await widget.viewmodel.changePchangePasswordOnLoginassword(
        _passwordController.text,
      );
      _isLoading = false;
      rst.when(
        success: (data) {
          if (mounted) context.pop();
        },
        failure: (msg, err) {
          setState(() {
            _isLoading = false;
            _errorMessage = msg;
          });
        },
      );
    } else {
      setState(() {
        _errorMessage = '数据格式出错';
        _isLoading = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('确认退出'),
                content: Text('确定要退出登录吗？'),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(false),
                    child: Text('取消'),
                  ),
                  TextButton(
                    onPressed: () {
                      // 执行退出操作
                      context.pop(true); // 关闭应用（根据需求修改）
                      // 如果只是返回上一页可以使用：
                      // Navigator.of(context).pop(true);
                    },
                    child: Text('确定', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
        ) ??
        false;
  }

  bool isEdited() {
    return _passwordConfirmController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty;
  }

  void _onPopInvokedWithResult(didPop, result) async {
    if (didPop) {
      return;
    }
    final bool shouldPop = await _onWillPop();
    if (mounted && shouldPop) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 400),
        child: Card(
          color: AppColors.active,
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              canPop: !isEdited(),
              onPopInvokedWithResult: _onPopInvokedWithResult,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "重置密码",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop(true);
                        },
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '密码',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入密码';
                      }
                      if (value.length < 6) {
                        return '密码至少需要6个字符';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                      labelText: '确认密码',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请确认密码';
                      }
                      if (value.length < 6) {
                        return '密码至少需要6个字符';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20),
                  if (_errorMessage.isNotEmpty)
                    Text(_errorMessage, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _confirm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child:
                          _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                '确定',
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
