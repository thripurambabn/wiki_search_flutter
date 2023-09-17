import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotFoundWidget extends StatelessWidget {
  final String searchKeyword;

  const NotFoundWidget({
    super.key,
    required this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 7.0),
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
          color: Colors.amberAccent[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We searched for - ",
              ),
              SizedBox(
                width: 1.sw,
                height: 20.0,
                child: Text(
                  searchKeyword,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Text(
                "and found no results on wikipedia",
              ),
              const Text(
                "\nSuggestions :",
              ),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: const Text(
                  "\n\u2022 Make sure that all the words are spelled correctly.\n\u2022 Try different keywords.\n\u2022 Try more general keywords.\n\u2022 Go to stackoverflow.com",
                ),
              ),
              const SizedBox(height: 5)
            ],
          ),
        ),
      ],
    );
  }
}
