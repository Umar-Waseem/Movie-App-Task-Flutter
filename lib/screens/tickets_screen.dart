import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/models/movie_model.dart';
import 'package:movie_app_task/themes/colors.dart';
import 'package:movie_app_task/utils/widget_extensions.dart';

import '../widgets/seats_option_card_widget.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        foregroundColor: Colors.black,
        backgroundColor: kAppBarBackgroundColor,
        elevation: 0,
        title: Column(
          children: [
            Text(
              widget.movie.original_title,
              style: const TextStyle(),
            ),
            10.ph,
            Text(
              "In Theaters ${widget.movie.release_date}",
              style: const TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            10.ph,
            const Text(
              "Date",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            10.ph,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("5 Mar"),
                    onPressed: () {},
                  ),
                  10.pw,
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("6 Mar"),
                    onPressed: () {},
                  ),
                  10.pw,
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("7 Mar"),
                    onPressed: () {},
                  ),
                  10.pw,
                  ActionChip(
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    label: const Text("8 Mar"),
                    onPressed: () {},
                  ),
                  10.pw,
                ],
              ),
            ),
            20.ph,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SeatsOptionCardWidget(),
                  10.pw,
                  const SeatsOptionCardWidget(),
                  10.pw,
                  const SeatsOptionCardWidget(),
                ],
              ),
            ),
            Expanded(child: Container()),
            Center(
              child: Container(
                padding: const EdgeInsets.only(right: 20),
                width: double.infinity,
                child: CupertinoButton(
                  color: kLightBlue,
                  child: const Text("Select Seats"),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
