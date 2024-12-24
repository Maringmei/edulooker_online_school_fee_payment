import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/constants/colors/color_constants.dart';
import '../../../../../../core/constants/widgets/logout_dialog.dart';
import '../../../../../../core/constants/widgets/text_widgets.dart';
import '../../../../../../core/storage/storage.dart';
import '../../../../../../route/router_list.dart';

class SliverTitle extends StatefulWidget {
  final Widget child;

  const SliverTitle({
    super.key,
    required this.child,
  });

  @override
  _SliverTitleState createState() => _SliverTitleState();
}

class _SliverTitleState extends State<SliverTitle> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context).position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible ?? true, // Set default visibility to true
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: widget.child,
          ),
          IconButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) {
                  return LogoutDialog(context: context);
                },
              ).then((value) {
                if (value == true) {
                  Store.clear();
                  context.go(RouteList.login);
                }
              });
            },
            icon: Column(
              children: [
                Icon(
                  Icons.logout,
                  color: KColor.red,
                  size: 14,
                ),
                TextWidget(
                  text: "Logout",
                  fontSize: 8,
                  tColor: KColor.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
