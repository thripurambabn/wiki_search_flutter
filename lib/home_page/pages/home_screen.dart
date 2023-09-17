import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/search_textfield.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
  decoration:  BoxDecoration(
  color: Colors.amberAccent[100],
  ),
        padding: EdgeInsets.symmetric(vertical: 10.0.h,horizontal:10.w),
       
        child:  Column(
                      children: [
                        SizedBox(height: 120.h,),
                        Image.asset('assets/images/wiki_image.png'),
                        SizedBox(height:50.h),
                       const SearchWidget(),
                      ],
                    ),
              ),
    );
  }

}