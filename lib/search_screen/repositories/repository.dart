

import 'package:freo_flutter_assignment/search_screen/repositories/services/wiki_network_service.dart';

import '../../home_page/models/wiki_search_result/wiki_search_result.dart';

class Repository {
  static Future<WikiSearchResult> searchWikiPages(String searchKeyword) async {
    try {
      WikiSearchResult searchResult =
          await WikiNetworkService.getWikiPages(searchKeyword);
      return searchResult;
    } catch (e) {
      rethrow;
    }
  }
}
