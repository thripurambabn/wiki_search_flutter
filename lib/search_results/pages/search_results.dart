import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../search_screen/wiki_search/wikisearch_cubit.dart';
import '../widgets/nointernet_widget.dart';
import '../widgets/notfound_widget.dart';
import '../widgets/search_widget.dart';
import '../widgets/wiki_tile.dart';

class SearchResults extends StatefulWidget {
  final String searchKeyword;
  const SearchResults({super.key, required this.searchKeyword});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WikisearchCubit>(context)
        .fetchWikiPages(widget.searchKeyword);
  }

  Future<void> _refreshfetchWikiPages(WikisearchCubit cubit) async {
    try {
      await cubit.fetchWikiPages(widget.searchKeyword, isRefresh: true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<WikisearchCubit>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacementNamed(context, "/home");
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.amberAccent[100],
        body: BlocBuilder<WikisearchCubit, WikisearchState>(
          builder: (context, state) => SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                SearchWidget(
                  state: state,
                  searchKeyword: widget.searchKeyword,
                ),
                Expanded(
                  child: Scrollbar(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: state is WikisearchError
                          ? _getBodyWidget(cubit, state)
                          : RefreshIndicator(
                              onRefresh: () {
                                return _refreshfetchWikiPages(cubit);
                              },
                              child: _getBodyWidget(cubit, state),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getBodyWidget(WikisearchCubit cubit, WikisearchState state) {
    return SizedBox(
      height: 1.sh - 188,
      width: 1.sw,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: _getSearchResultsWidget(cubit, state),
      ),
    );
  }

  _getSearchResultsWidget(WikisearchCubit cubit, WikisearchState state) {
    if (state is WikisearchLoaded) {
      return Container(
        color: Colors.amberAccent[100],
        child: Column(
          children: [
            SizedBox(height: 9.0.h),
            for (int page = 0; page < cubit.pages.length; page++)
              WikiTile(page: cubit.pages[page])
          ],
        ),
      );
    } else if (state is WikisearchNotFound) {
      return NotFoundWidget(
        searchKeyword: widget.searchKeyword,
      );
    } else if (state is WikisearchError) {
      return NoInternetWidget(
        callback: () {
          cubit.fetchWikiPages(widget.searchKeyword);
        },
      );
    }
  }
}
