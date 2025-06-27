import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/route/routes.dart';
import 'package:jing_hong_v4/ui/auth/auth_viewmodel.dart';
import 'package:jing_hong_v4/ui/theme/colors.dart';

// 独立元素不多，就在当前文件中描写

class LoginScreen extends StatefulWidget {
  final AuthViewmodel viewmodel;

  const LoginScreen({super.key, required this.viewmodel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = "";
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final rst = await widget.viewmodel.login(
        UserInfo(
          username: _usernameController.text,
          password: _passwordController.text,
        ),
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
        _errorMessage = '用户名或密码错误';
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
    return _usernameController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty ||
        _isLoading;
  }

  void _onPopInvokedWithResult(didPop, result) async {
    if (didPop) {
      return;
    }
    final bool shouldPop = await _onWillPop();
    if (!shouldPop) return;
    closeScreen();
  }

  void closeScreen() {
    if (mounted) {
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
                  Icon(Icons.account_circle, size: 100),
                  SizedBox(height: 40),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "用户名",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入用户名';
                      }
                      if (!RegExp(
                        r'^[A-Za-z]+[A-Za-z_\*\@\&]*$',
                      ).hasMatch(value)) {
                        return '用户名只允许英文大小写和_*@&';
                      }
                      return null;
                    },
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
                  if (_errorMessage.isNotEmpty)
                    Text(_errorMessage, style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child:
                          _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                '登录',
                                style: TextStyle(color: Colors.white),
                              ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {}, child: Text('忘记密码?')),
                      TextButton(
                        onPressed: () async {
                          final rst = await context.push(Routes.register);
                          if (rst == true) return;
                          closeScreen();
                        },
                        child: Text('注册账号'),
                      ),
                    ],
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
