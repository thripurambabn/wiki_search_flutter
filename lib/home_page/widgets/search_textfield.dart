import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white.withOpacity(0.5)),
      child: MaterialButton(
        onPressed: () {
          Navigator.pushNamed(context, "/search");
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0.r),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              color: Colors.black,
            ),
            SizedBox(width: 10.0.w),
            const Text(
              "Search Wikipedia",
            ),
          ],
        ),
      ),
    );
  }
}
