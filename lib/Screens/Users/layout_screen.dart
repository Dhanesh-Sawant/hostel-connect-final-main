import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/colors.dart';
import '../../Utils/home_screen_items.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key, required this.pageset}) : super(key: key);

  static String PageRoute = 'LayoutScreen';

  final int pageset;

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  int _pageNo = 0;
  // pagecontroller is the link between widget in the body to that of the bottombar


  late PageController pageController;

  void NavigationTapped(int page){
    pageController.jumpToPage(page); // pagecontroller will jump to page given and make the page view change
  }

  void onpageChanged(int page){
    setState(() {
      _pageNo = page;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: widget.pageset);
    _pageNo = widget.pageset;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // pageview is what we see after we change by pagecontroller and it is indexed
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onpageChanged,
        physics: NeverScrollableScrollPhysics(), // to disable pageview by swiping left and right
        // onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.grey.withOpacity(0.06),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: _pageNo==0 ? purplemaincolor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work,
              color: _pageNo==1 ? purplemaincolor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _pageNo==2 ? purplemaincolor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          )
        ],
        onTap: NavigationTapped,
      ),
    );
  }
}
