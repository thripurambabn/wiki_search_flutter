import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/routes.dart';
import '../search_cache/searchcache_cubit.dart';
import '../widgets/search_history_list.dart';

class SearchScreen extends StatefulWidget {
  final String? searchKeyword;

  const SearchScreen({super.key, required this.searchKeyword});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();

   late final SearchcacheCubit  searchcacheCubit ;
  @override
  void initState() {
    super.initState();

   searchcacheCubit = BlocProvider.of<SearchcacheCubit>(context);
    searchcacheCubit.populateSearchHistory();
    _textEditingController.text =
        widget.searchKeyword == null ? "" : widget.searchKeyword!;
   
  }

  Future<void> _updateSearchCache(BuildContext context,
      String searchKeyword, SearchcacheCubit cubit) async {
    await cubit.updateSearchHistory(searchKeyword);
    if(!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      "/wikiResults",
      arguments: WikiSearchArguments(
        searchKeyword: searchKeyword,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.amberAccent[100],
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                   Expanded(
                    child: TextField(
                              controller: _textEditingController,
                             onSubmitted: (searchKeyword) {
                        if (searchKeyword.isNotEmpty) {
                          _updateSearchCache(context,searchKeyword, searchcacheCubit);
                        }
                      },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.5),
                                hintText: 'Search...',
                                // Add a clear button to the search bar
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => _textEditingController.clear(),
                                ),
                                // Add a search icon or button to the search bar
                                prefixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                    // Perform the search here
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          width: 1, color: Colors.white.withOpacity(0.5)), 
           borderRadius: BorderRadius.circular(30.0.r),//<-- SEE HERE
        ),
                               focusedBorder: OutlineInputBorder( //<-- SEE HERE
         borderSide: BorderSide(
          width: 1, color: Colors.white.withOpacity(0.5)),
           borderRadius: BorderRadius.circular(30.0.r),//
        ),
                              ),
                            ),
                  ), 
       
            ]),
          
                  
              BlocBuilder<SearchcacheCubit, SearchcacheState>(
                builder: (context, state) {
                  if (state is SearchcacheLoaded) {
                    return Expanded(
                      child: SearchHistoryList(
                        searchHistory: searchcacheCubit.searchHistory!,
                        callback: (String searchText) {
                          setState(() {
                            _textEditingController.text = searchText;
                          });
                          _updateSearchCache(context,searchText, searchcacheCubit);
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ])
        ),
      ),
    );
  }
}
