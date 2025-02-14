import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          height: 125,
          index: 2,
          textCenter: 'Đèn Taplo',
          items: <CurveItem>[
            CurveItem(icon: Icons.add.toString(), iconSelected: Icons.add.toString(), title: 'Trang chủ'),
            CurveItem(icon: Icons.add.toString(), iconSelected: Icons.add.toString(), title: 'Trang chủ'),
            CurveItem(
              icon: "assets/icons/info.png",
              iconSelected: "assets/icons/info.png",
            ),
            CurveItem(icon: Icons.add.toString(), iconSelected: Icons.add.toString(), title: 'Trang chủ'),
            CurveItem(icon: Icons.add.toString(), iconSelected: Icons.add.toString(), title: 'Trang chủ'),
          ],
          color: Colors.white,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(_page.toString(), style: TextStyle(fontSize: 160)),
                ElevatedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
                    navBarState?.setPage(1);
                  },
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.red,
                      height: 50,
                      child: Text("$index"),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                ),
                SizedBox(height: 125),
              ],
            ),
          ),
        ));
  }
}
