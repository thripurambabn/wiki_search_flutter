import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchHistoryList extends StatelessWidget {
  final Queue<String> searchHistory;
  final Function callback;

  const SearchHistoryList({
    super.key,
    required this.searchHistory,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          children: [
            for (int search = 0; search < searchHistory.length; search++)
              SizedBox(
                height: 50.0,
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  onPressed: () {
                    callback(searchHistory.elementAt(search));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.history),
                      const SizedBox(width: 30.0),
                      SizedBox(
                        width: 1.sw - 180.0,
                        child: Text(
                          searchHistory.elementAt(search),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      const RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: Icon(Icons.arrow_back),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
