import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterbucketapp/database.dart';
import 'package:flutterbucketapp/user.dart';
import 'package:sqflite/sqflite.dart';
import 'DetailScreen.dart';
import 'EditScreen.dart';
import 'bucket.dart';

class HomePage extends StatefulWidget {

  User user;
  HomePage({Key key, @required this.user}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Bucket> bucketList = List();
  Color _tileColor1 = Colors.cyan[50];
  Color _tileColor2 = Colors.cyan[200];


  void refresh() async {
    print(widget.user.name);
    List<Map<String, dynamic>> _results = await DB.query(Bucket.table,  widget.user.name);
    setState(() {
      bucketList = _results.map((item) => Bucket.fromJson(item)).toList();
    });
  }

  void _delete(Bucket item) async {
    DB.delete(Bucket.table, item);
    refresh();
  }

  void _save(Bucket item) async {
    await DB.insert(Bucket.table, item);
    setState(){};
    refresh();
  }







  @override
  Widget build(BuildContext context) {

    refresh();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                  "Total number of buckets " + (bucketList.length).toString()),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                // Let the ListView know how many items it needs to build.
                itemCount: bucketList.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.

                itemBuilder: (context, index) {
                  final item = bucketList[index];

                  return Container(
                      margin: EdgeInsets.all(4.0),
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: _tileColor1,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child:
                  Dismissible(
                      key: Key(item.name),
    onDismissed: (direction) {

    setState(() {
      bucketList.removeAt(index);
        _delete(item);
            refresh();
    });
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(content: Text("$item is deleted"), duration:  Duration(seconds: 1),));
    },

    child:
                      ListTile(
                          leading: (item.icon),
                          trailing: Text((item.getDate())),
                          title: Text(item.name),
                          subtitle: Text(item.description),
                          selectedTileColor: _tileColor2,
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        bucket: bucketList[index])));
                            setState(() {});
                          })

                  )
                  );
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey)),
                  padding: EdgeInsets.all(15.0),
                  child: Text("ADD NEW BUCKET"),
                  onPressed: () async {
                    print(widget.user.name);
                    Bucket bucket = new Bucket(
                      userName: widget.user.name,
                        name: "name ${bucketList.length}",
                        description: "",
                        date: DateTime.now());
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditScreen(bucket: bucket)));
                    setState(() {
                     _save(bucket);
                      refresh();
                      bucketList.add(bucket);
                      print(bucketList);
                    });
                    print(bucketList.length);

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
