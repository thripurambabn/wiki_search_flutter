import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page/pages/home_screen.dart';
import '../search_results/pages/search_results.dart';
import '../search_screen/pages/search_screen.dart';
import '../search_screen/search_cache/searchcache_cubit.dart';
import '../search_screen/wiki_search/wikisearch_cubit.dart';
import '../wiki_webview/wiki_webview.dart';

class AppRoutes {
  static MaterialPageRoute getMaterialRoute(screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }

  static PageRouteBuilder getPageRoute(screen) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, _, __) => screen,
    );
  }

  static Route? onGeneratedRoutes(RouteSettings route) {
    switch (route.name) {

      case "/home":
        return getMaterialRoute(
          const HomeScreen(),);

      case "/search":
        final WikiSearchArguments? args = route.arguments as WikiSearchArguments?;
        return getMaterialRoute(
          BlocProvider(
            create: (context) => SearchcacheCubit(),
            child: SearchScreen(
              searchKeyword: args?.searchKeyword,
            ),
          ),
        );

      case "/wikiResults":
        final args = route.arguments as WikiSearchArguments;
        return getPageRoute(
          BlocProvider(
            create: (context) => WikisearchCubit(),
            child: SearchResults(searchKeyword: args.searchKeyword),
          ),
        );

      case "/webview":
        final args = route.arguments as WikiWebViewArguments;
        return getMaterialRoute(WikiWebView(url: args.url));
    }
    return null;
  }
}


class WikiSearchArguments {
  final String searchKeyword;

  WikiSearchArguments({
    required this.searchKeyword,
  });
}

class WikiWebViewArguments {
  final String url;

  WikiWebViewArguments({
    required this.url,
  });
}
