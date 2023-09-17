import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class NoInternetWidget extends StatelessWidget {
  final Function callback;

  const NoInternetWidget({super.key, 
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent[100],
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: 1.sw,
            decoration: BoxDecoration(
              color: Colors.amberAccent[100],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/images/no_internet.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      SizedBox(
                        width: 1.sw - 170,
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mobile data is off",
                            ),
                            SizedBox(height: 10.0.h),
                            const Text(
                              "No data connection. Consider turning on mobile data or turning on Wi-Fi.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.sw ,
                  height: 1,
                  color: const Color(0xff444647),
                ),
                _getButtonTile(
                  "Turn on Wi-Fi / mobile data",
                  Icons.settings,
                  () {
                 //   AppSettings.openAppSettings();
                  },
                ),
                Container(
                  width:1.sw ,
                  height: 1,
                  color: const Color(0xff444647),
                ),
                _getButtonTile(
                  "Try again",
                  Icons.refresh,
                  () {
                    callback();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _getButtonTile(
        String text, IconData iconData, Function callback) =>
    SizedBox(
      width: 1.sw ,
      height: 50.0,
      child: MaterialButton(
        highlightColor: const Color(0xff1D2328),
        splashColor: Colors.transparent,
        onPressed: () {
          callback();
        },
        child: Row(
          children: [
            Icon(
              iconData,
              color: const Color(0xff737575),
            ),
            const SizedBox(width: 10.0),
            Text(
              text,
              // style: GoogleFonts.montserrat(
              //   color: Color(0xff737575),
              // ),
            )
          ],
        ),
      ),
    );
