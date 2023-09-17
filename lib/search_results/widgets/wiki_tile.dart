import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/routes.dart';
import '../../home_page/models/wikipage/wiki_page.dart';

class WikiTile extends StatelessWidget {
  final WikiPage page;

  const WikiTile({
    super.key,
    required this.page,
  });

  getDescriprion() {
    return page.description != null
        ? page.description![0].toUpperCase() + page.description!.substring(1)
        : "Description not found";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/webview",
          arguments: WikiWebViewArguments(url: page.fullurl),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        padding: const EdgeInsets.only(bottom: 10.0),
        width: 1.sw,
        color: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page.title,
                  ),
                  Container(
                    height: 1,
                    width: 1.sw,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  SizedBox(height: 10.0.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          "Description: ${getDescriprion()}",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      page.thumbnail == null
                          ? const SizedBox()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: CachedNetworkImage(
                                  imageUrl: page.thumbnail!,
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
