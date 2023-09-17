import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../home_page/models/wiki_search_result/wiki_search_result.dart';
import '../../home_page/models/wikipage/wiki_page.dart';
import '../repositories/repository.dart';
part 'wikisearch_state.dart';

class WikisearchCubit extends Cubit<WikisearchState> {
  List<WikiPage> pages = [];
  final Queue _articlesCache = Queue();
  final _box = Hive.box("search-cache");

  WikisearchCubit() : super(WikisearchInitial());
  Future<void> fetchWikiPages(String searchKeyword,
      {bool isRefresh = false}) async {
    if (!isRefresh) emit(WikisearchInitial());
    try {
      WikiSearchResult searchResult =
          await Repository.searchWikiPages(searchKeyword);
      if (searchResult.gpsoffset == null) {
        emit(WikisearchNotFound());
      } else {
        pages.clear();
        searchResult.pages.sort((a, b) => a.index.compareTo(b.index));
        pages = searchResult.pages;
        updateLocalCache(searchKeyword);
        emit(WikisearchLoaded());
      }
    } catch (e) {
      if (isRefresh) {
        throw Exception(
          "Failed to refresh, please check your network and try again!",
        );
      } else {
        bool cacheAvailable = await getLocalCache(searchKeyword);
        if (cacheAvailable) {
          emit(WikisearchLoaded());
        } else {
          emit(WikisearchError());
        }
      }
    }
  }

  Future<void> updateLocalCache(String searchKeyword) async {
    List? articles = _box.get("articles");
    if (articles != null) {
      _articlesCache.clear();
      for (var article in articles) {
        _articlesCache.add(article);
      }
    }

    var cacheData = {
      "keyword": searchKeyword,
      "results": pages,
    };
    List results = _articlesCache
        .where((article) => article["keyword"] == searchKeyword)
        .toList();

    if (results.isEmpty) {
      _articlesCache.addFirst(cacheData);
      if (_articlesCache.length > 10) _articlesCache.removeLast();
    } else {
      _articlesCache
          .removeWhere((article) => article["keyword"] == searchKeyword);
      _articlesCache.addFirst(cacheData);
    }
    await _box.put("articles", List.from(_articlesCache));
  }

  Future<bool> getLocalCache(String searchKeyword) async {
    List? articles = _box.get("articles");
    if (articles != null) {
      for (var article in articles) {
        _articlesCache.add(article);
      }

      List filteredResult = _articlesCache
          .where((element) => element["keyword"] == searchKeyword)
          .toList();

      if (filteredResult.isNotEmpty) {
        List articles = filteredResult.first["results"] as List;
        pages.clear();
        for (var page in articles) {
          pages.add(page);
        }
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
