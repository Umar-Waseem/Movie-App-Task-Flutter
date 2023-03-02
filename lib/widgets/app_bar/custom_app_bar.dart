import 'package:flutter/material.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

import '../../themes/colors.dart';
import '../icons/search_icon.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, required this.isSearchBarVisible, this.toggleSearchBarVisibility, required this.slideAnimation}) : super(key: key);

  final bool isSearchBarVisible;
  final Function()? toggleSearchBarVisibility;
  final Animation<Offset> slideAnimation;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      foregroundColor: Colors.black,
      backgroundColor: kAppBarBackgroundColor,
      title: AnimatedBuilder(
        animation: widget.slideAnimation,
        builder: (context, child) {
          return SlideTransition(
            position: widget.slideAnimation,
            child: child,
          );
        },
        child: Visibility(
          visible: widget.isSearchBarVisible,
          replacement: const Text('Watch').paddingLeft(0),
          child: TextField(
            cursorColor: Colors.black,
            decoration: InputDecoration(
              filled: true,
              fillColor: kBackgroundColor,
              prefixIcon: SearchIcon(
                onPressed: widget.toggleSearchBarVisibility,
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.black),
                onPressed: widget.toggleSearchBarVisibility,
              ),
              hintText: 'TV Shows, Movies and more',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      actions: [
        widget.isSearchBarVisible
            ? Container()
            : SearchIcon(
                onPressed: widget.toggleSearchBarVisibility,
              ),
      ],
    );
  }
}
