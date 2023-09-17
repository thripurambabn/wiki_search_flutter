import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freo_flutter_assignment/home_page/models/wikipage/wiki_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'data/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(WikiPageAdapter());
  await Hive.openBox("search-cache");
  runApp(const ScreenUtilInit(
      ensureScreenSize: true,
      child: WikiSearch()));
}

class WikiSearch extends StatelessWidget {
  const WikiSearch({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGeneratedRoutes,
      initialRoute:  "/home",
    );
  }
}
