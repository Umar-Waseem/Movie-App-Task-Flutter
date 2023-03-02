import 'package:flutter/material.dart';
import 'package:movie_app_task/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../themes/colors.dart';
import '../widgets/app_bar/custom_app_bar.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  bool _isSearchBarVisible = false;

  late final AnimationController _animationController;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.4, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearchBarVisibility() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
    });
    if (_isSearchBarVisible) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(
          isSearchBarVisible: _isSearchBarVisible,
          toggleSearchBarVisibility: _toggleSearchBarVisibility,
          slideAnimation: _slideAnimation,
        ),
      ),
      backgroundColor: kAppBarBackgroundColor,
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) => Center(
          child: ListView(
            children: movieProvider.allMovies,
          ),
        ),
      ),
    );
  }
}
