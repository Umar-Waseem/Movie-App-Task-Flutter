import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../themes/colors.dart';
import '../widgets/app_bar/custom_app_bar.dart';
import '../widgets/nav_bar/nav_bar_widget.dart';

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
      begin: const Offset(0.2, 0),
      end: const Offset(0, 0),
    ).animate(_animationController);

    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    movieProvider.getUpcomingMovies();
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
          child: movieProvider.loading
              ? const CupertinoActivityIndicator(
                  animating: true,
                  color: kNavBarColor,
                  radius: 15,
                )
              : movieProvider.moviesToShowList.isEmpty
                  ? const Center(
                      child: Text(
                        "No Results Found",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )
                  : ListView(
                      children: movieProvider.moviesToShowList,
                    ),
        ),
      ),
      bottomSheet: const CustomNavBar(),
    );
  }
}
