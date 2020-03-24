import 'dart:collection';
import 'dart:convert';

import 'package:clientside/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import 'package:clientside/constants.dart';

class TestPage extends StatelessWidget {
  final queuedTableNo = '03';
  final queuedItem = 'Chicken Biryani';
  final queuedAT = '24';
  final currentTableNo = '04';
  final currentItem = 'Pakoda';
  final currentAT = '30';

  Future<Order> fetchOrders() async {
    String url = 'http://192.168.0.9:5050/fetch_orders';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"title": "Hello", "body": "body text", "userId": 1}';
    http.Response response = await http.post(url);
    final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    channel.stream.listen((message) {
      print(message);
      channel.sink.add("received!");
      channel.sink.close(status.goingAway);
    });
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      Order order = new Order.fromJson(decodedData);
      return order;
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    var order = fetchOrders();
    orderS = new ListQueue<String>();
    orderS.add("value");
    orderS.add("value 2");
    orderS.add("value 3");
    orderS.add("value 4");
    orderS.forEach((f) {
//      print(f);
    });
    print(orderS.removeFirst());
    print(orderS.removeFirst());
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<Order>(
          future: order,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.blueGrey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Assistance',
                                style: homePageS1,
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Table',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Type',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Time',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Status',
                                        style: homePageS1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 40,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 12),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              '06',
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'water',
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              '3:40',
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              'Pending',
                                              style: homePageS2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding: EdgeInsets.all(8),
                        color: Colors.grey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Queued',
                                style: homePageS1,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Text(
                                          snapshot.data.table,
                                          style: homePageS1,
                                        ),
                                      ),
                                      ListView.builder(
                                        primary: false,
                                        itemCount:
                                        snapshot.data.foodlist.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot.data
                                                      .foodlist['$index'].name,
                                                  style: homePageS3,
                                                ),
                                                Text(
                                                  'Arrived Time : $queuedAT m ago',
                                                  style: homePageS3,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.blueGrey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Current',
                                style: homePageS1,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        child: Text(
                                          'Table No : $currentTableNo',
                                          style: homePageS1,
                                        ),
                                      ),
                                      ListView.builder(
                                        primary: false,
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  currentItem,
                                                  style: homePageS3,
                                                ),
                                                Text(
                                                  'Arrived Time : $currentAT m ago',
                                                  style: homePageS3,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Divider(
                                        thickness: 2,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner while loading  server data.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
