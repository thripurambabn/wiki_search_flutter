import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/routes.dart';
import '../../search_screen/wiki_search/wikisearch_cubit.dart';

class SearchWidget extends StatelessWidget {
  final WikisearchState state;
  final String searchKeyword;

  const SearchWidget({super.key, 
    required this.state,
    required this.searchKeyword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(top: 20.0.h, bottom: 20.0.h),
      
      width:1.sw,
      color: Colors.amberAccent[100],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "WikiSearch",
          ),
           SizedBox(height: 30.0.h),
          Stack(
            clipBehavior: Clip.none,
            children: [
              state is WikisearchInitial
                  ? Positioned(
                      bottom: -2.0,
                      left: 35,
                      child: SizedBox(
                        width: 1.sw - 67.5,
                        child: ClipRRect(
                          borderRadius:  BorderRadius.only(
                            bottomLeft: Radius.circular(30.0.r),
                            bottomRight: Radius.circular(30.0.r),
                          ),
                          child: const LinearProgressIndicator(
                            color: Colors.amberAccent,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 10.0.w),
                height: 55.h,
                child: MaterialButton(
                  elevation: 10.0,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/search",
                      arguments: WikiSearchArguments(
                        searchKeyword: searchKeyword,
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white.withOpacity(0.5),
                  splashColor:const Color(0xff585A5C),
                  highlightColor:const Color(0xff585A5C).withOpacity(0.5),
                  child: Row(
                    children: [
                    const  Icon(
                        Icons.search,
                        color: Color(0xff7A7E81),
                      ),
                    const  SizedBox(width: 10.0),
                      SizedBox(
                        width: 1.sw - 126,
                        child: Text(
                          searchKeyword,
                          //style: AppTheme.searchTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
