import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  final String? title;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Action? actions;
  final bool? isSingleChildScrollView;
  const DefaultLayout({
    this.actions,
    this.bottomNavigationBar,
    this.title,
    required this.child,
    this.backgroundColor,
    this.floatingActionButton,
    this.isSingleChildScrollView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppBar(context),
      body: isSingleChildScrollView ?? false
          ? SingleChildScrollView(child: child)
          : child,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        backgroundColor: backgroundColor ?? Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title!,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/images/arrow.svg',
            height: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }
}
