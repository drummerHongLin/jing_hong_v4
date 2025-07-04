import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jing_hong_v4/data/model/auth/user_info.dart';
import 'package:jing_hong_v4/route/routes.dart';
import 'package:jing_hong_v4/ui/auth/auth_viewmodel.dart';
import 'package:jing_hong_v4/ui/common/circle_img.dart' show CircleNetImg;
import 'package:jing_hong_v4/ui/theme/colors.dart' show AppColors;
import 'package:jing_hong_v4/utils/result.dart';

class ProfileScreen extends StatefulWidget {
  final AuthViewmodel viewmodel;

  const ProfileScreen({super.key, required this.viewmodel});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewmodel.loadUserInfo.execute();
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
            child: ListenableBuilder(
              listenable: widget.viewmodel.loadUserInfo,
              builder: (context, c) {
                if (widget.viewmodel.loadUserInfo.running) {
                  return  SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    
                  );
                } else if (widget.viewmodel.loadUserInfo.error) {
                  return  SizedBox(
                      height: 100,
                      width: 100,
                      child: Text(
                        (widget.viewmodel.loadUserInfo.result as Failure)
                            .message,
                      ),
                  
                  );
                } else {
                  return _success(
                    (widget.viewmodel.loadUserInfo.result as Success<UserInfo>)
                        .data,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _success(UserInfo userInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 10,
      children: [
        CircleNetImg(
          imgUrl:
              'https://www.honghouse.cn/api/v1/users/${userInfo.username}/get-avatar',
          imgSize: Size(200, 200),
          headers: <String, String>{
            "Authorization": "Bearer ${userInfo.token}",
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final r = await context.push(Routes.setAvatar);
                if (r == true) {
                  widget.viewmodel.loadUserInfo.execute();
                }
              },
              child: Text("更改头像"),
            ),
            TextButton(onPressed: () {
              context.push(Routes.changePassword);
            }, child: Text("更改密码")),
          ],
        ),
      ],
    );
  }
}
