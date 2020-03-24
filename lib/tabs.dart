import 'package:clientside/home/home.dart';
import 'package:clientside/person/personView.dart';
import 'package:clientside/table/tableView.dart';
import 'package:flutter/material.dart';

class TabContainerBottom extends StatefulWidget {
  @override
  _TabContainerBottomState createState() => _TabContainerBottomState();
}

class _TabContainerBottomState extends State<TabContainerBottom> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              PersonView(),
              HomePage(),
              TableView(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Person',
              ),
              Tab(
                icon: Icon(Icons.home),
                text: 'HOME',
              ),
              Tab(
                icon: Icon(Icons.table_chart),
                text: 'Table',
              ),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
