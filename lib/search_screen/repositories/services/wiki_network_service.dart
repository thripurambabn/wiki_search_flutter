import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../data/api_constants.dart';
import '../../../home_page/models/wiki_search_result/wiki_search_result.dart';

class WikiNetworkService {
  static Future<WikiSearchResult> getWikiPages(String search,
      {int gpsoffset = 0}) async {
    try {
      var response = await http.get(Uri.parse(
        '${ApiEndPoints.wikiUrl}&gpssearch=$search&gpsoffset=$gpsoffset',
      ));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return WikiSearchResult.fromJson(result);
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (e) {
      throw Exception("No Internet Connection");
    }
  }
}
