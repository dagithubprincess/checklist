import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_checklist/model/rung.dart';
import '../controller/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:my_checklist/static/settings.dart';

class MyCustomUI extends StatefulWidget {
  const MyCustomUI({super.key});

  @override
  State<MyCustomUI> createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI> {
  final List<Rung> _items = Rung.myList;
  List<Rung> newList = [];
  final List<Rung> _removeditems = [];
  bool _switchVal = false;
  bool flag = false;
  SharedPreferences? prefs;
  int rungObjIndex = 0;
  final AsyncMemoizer memoizer = AsyncMemoizer();

  get _showSnack => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: Text('Task deleted'),
    duration: Duration(milliseconds: 500),
  ));

  checkPrefsUploaded() async{
    dev.log('A6 - CheckPrefsUploaded()');
    SharedPreferences.getInstance().then((prefs) async {
      this.prefs = await SharedPreferences.getInstance();
    });
    for (Rung rung in Rung.myList) {
      loadRungObjPrefs(rung.rungId);
      if (rung.archive == true) {
        _removeditems.add(rung);
        if(_items.isNotEmpty) {
          _items.removeWhere((element) => element == rung);
        }
      }
    }
    dev.log(
        '_item list len: ${_items.length} and _removeditems list len: ${_removeditems.length}');
    Rung.myList.sort((a, b) => a.index.compareTo(b.index));
  }

  Future<void> updateUI() async {
    dev.log('A7 - updateUI()');
    await getCurrentList();
    setState(() {});
  }

  Future<void> getCurrentList() async {
    await Future.delayed(const Duration(seconds: 2));
    newList = _items;
    flag == false;
    setState(() {
      dev.log('A8 - getCurrentList setstate');
    });
  }

  Future<List<Rung>> getItems() async {
    dev.log('A1 - getItems()');

    await memoizer.runOnce(() async {
      dev.log('A2 - Memoizer - instance db');
      await DatabaseHelper.instance.database;
      await checkPrefsUploaded();
      updateUI();
    });
    return _items; //Rung.myList;
  }


  @override
  Widget build(BuildContext context) {
    // checkDBFull();
    //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    //final GlobalKey<DefaultTabController> _tabKey = GlobalKey<DefaultTabController>();
    return FutureBuilder(
        future: getItems(),
        //checkDataUploaded(), //_streamController.stream,
        builder: (BuildContext context, AsyncSnapshot<List<Rung>> snapshot) {
          // builder: (context, snapshot) {
          if (snapshot.hasData) {
            //

            // dev.log('SnapShot last rung name?: ${snapshot.data!.last.name}');
            dev.log('SnapShot hasData?: ${snapshot.hasData}');
            //  _items.add(snapshot.data!!!);
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                backgroundColor: const Color(0xffF8F9FB),
                appBar: AppBar(
                  elevation: 20,
                  shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
                  backgroundColor: Colors.white,
                  title: Text(
                    'Check List',
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  actions: [
                    IconButton(
                      color: Colors.black.withOpacity(.7),
                      tooltip: 'Settings',
                      enableFeedback: true,
                      icon: Icon(
                        CupertinoIcons.gear_alt_fill,
                        color: Colors.black.withOpacity(.7),
                      ),
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      },
                    ),
                  ],
                  bottom: TabBar(
                    indicatorColor: Colors.black.withOpacity(.8),
                    unselectedLabelStyle:
                    TextStyle(color: Colors.black.withOpacity(.5)),
                    unselectedLabelColor: Colors.black.withOpacity(.4),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black.withOpacity(.8),
                    tabs: const [
                      Tab(
                        child: Text(
                          'Check List',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Archive List',
                        ),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    mainCardWidget(context),
                    deleteCardWidget(context),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    TextEditingController controller = TextEditingController();
                    // dev.log('GOING to pop up form');
                    // const pop = PopupForm(context);
                    // dev.log('back from popupform');
//TODO Unable to edit name as is and the new addiiton or deletion is not reflecting on the UI
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: AlertDialog(
                            title: const Text("Add a new task"),
                            content: Column(
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Your task",
                                  ),
                                  controller: controller,
                                ),
                              ],
                            ),
                            actions: [
                              //       dev.log('onpressed-query', name: 'dogview.dart');
                              //     var dbquery = await DatabaseHelper.instance.queryDatabase();
                              // print(dbquery);
                              ElevatedButton(
                                onPressed: () async {
                                  // Do something when the user submits the form
                                  dev.log('Floating action : retrieve tasks');
                                  var dbquery = await DatabaseHelper.instance
                                      .queryDatabase();
                                  //print(dbquery);
                                  dev.log('Query db: $dbquery');
                                },
                                child: const Text("Query db"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.close),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  // TODO can you not add navigator.pop with async somehow?
                                  // Do something when the user submits the form
                                  dev.log(
                                      'Floating action : inserted a new task');
                                  dev.log(
                                      'Floating action : inserted a new task at ${Rung.myList.length}');
                                  if (controller.text !=
                                      '') {} //TODO might want to implement a pop up message here
                                  await DatabaseHelper.instance.insert(
                                    // {DatabaseHelper.colTask: controller.text});
                                      {
                                        //DatabaseHelper.colId: 1,
                                        //DatabaseHelper.colTask: 'testo 3',
                                        //int z = Rung.myList.length +1;
                                        // DatabaseHelper.colId: Rung.myList.length +1,
                                        DatabaseHelper.colTask: controller.text,
                                        DatabaseHelper.colDone: 0,
                                        DatabaseHelper.colBold: 0,
                                        DatabaseHelper.colInfo: '',
                                      });

                                  int currentRlen = Rung.myList.length + 1;
                                  String currentRlenStr =
                                  currentRlen.toString();
                                  Rung rung = Rung(
                                      rungId: currentRlenStr,
                                      name: controller.text.trim(),
                                      done: false,
                                      boldTitle: false,
                                      info: '',
                                      archive: false);
                                  dev.log(
                                      'Brand new task: rung no and name: $currentRlenStr + ${controller.text}');
                                  //Navigator.of(context).pop();
                                  setState(() {
                                    _items.add(rung);
                                  });

                                },
                                child: const Text("Submit task"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  tooltip: 'Add your task',
                  child: const Icon(Icons.add),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            dev.log('Snapshot has error');
            return Text('error: ${snapshot.error}');
          } else {
            //  dev.log('Snapshot : ${snapshot.data?.rungId}');
            //dev.log('after Snapshot : ${snapshot.data?.rungId}');
            dev.log('Circular progress Indicator');
            return const CircularProgressIndicator();
          }
        });
  }

  //TODO split here

  Widget mainCardWidget(BuildContext context) {
    //name, count, done
    // GlobalKey<ReorderableListView> _reorderKey = GlobalKey<ReorderableListView>();
    return ReorderableListView(
      // key: key,
      // key: ValueKey(index),
      onReorder: onReorder,
      physics:
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: _getListItems(),
      // children: [
      //   cardWithInfoPage(false, 'Toothpaste the blue and white stain cleansing kind', context),
      //   cardWithInfoPage(true, 'Hair brush', context),
      //   cardWithInfoPage(false, 'Toothpaste the blue and white stain cleansing kind', context),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Rung element = _items.removeAt(oldIndex);
      _items.insert(newIndex, element);
      dev.log('onReorder - rung info index updated');
      setRungObjPrefs(element.rungId, newIndex);
    });
  }

  List<Widget> _getListItems() => _items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  List<Widget> _getRemovedListItems() => _removeditems
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile2(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(Rung item, int index) {
    return Dismissible(
      //key: Key(item.rungId),
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          _items.removeAt(index);
          _removeditems.add(item);
          item.archive = true;
        });
      },
      background: Container(color: Colors.red),
      //cardWithInfoPage
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(child: cardWithInfoPage(item, context, index)),
      ),
    );
  } // widget build tenable

  Widget _buildTenableListTile2(Rung item, int index) {
    return Dismissible(
      // key: Key(item.rungId),
      key: UniqueKey(),
      onDismissed: (direction) {
        setState(() {
          _removeditems.removeAt(index);
          _items.add(item);
          item.archive = false;
        });
      },
      background: Container(color: Colors.red),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(child: cardWithInfoPage2(item, context, index)),
      ),
    );
  }

  Widget cardWithInfoPage(item, BuildContext context, index) {
    return cardWidget(context, infoPage(item.name, context), item, index);
  }

  Widget cardWidget(BuildContext context, Widget route, item, index) {
    double w = MediaQuery.of(context).size.width;
    double f = MediaQuery.of(context).textScaleFactor;
    String itemT = item.name;
    String itemID = item.rungId;
    bool itemD = item.done;
    bool itemB = item.boldTitle;
    int itemDno = 0;
    int itemBno = 0;
    String itemI = item.info;
    //bool switchVal = false;
    // dev.log('Widget cardWidget info');
    return NotificationListener(
      child: SizedBox(
        child: Container(
          // color: Colors.greenAccent,
          // margin: EdgeInsets.all(w/15),
          //padding: EdgeInsets.all(w / 40),

          //child: Center(
          child: ReorderableDragStartListener(
            index: index,
            child: InkWell(
              enableFeedback: true,
              // splashColor: Colors.blueGrey,
              // highlightColor: Colors.purple,
              onDoubleTap: () {
                setState(() {
                  item.done = !item.done;
                });
              },

              onLongPress: () {
                // setState(() {
                //   item.boldTitle = !item.boldTitle;
                // });
                TextEditingController controller = TextEditingController();
                dev.log('Main card - Edit bold form');

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: SizedBox(
                        //TODO media widget measurements rather than the fixed measurements
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: AlertDialog(
                          title: const Text("Edit task"),
                          content: StatefulBuilder(
                            builder: (BuildContext context,
                                void Function(void Function()) setState) {
                              return Column(
                                children: [
                                  const Text('Edit your task name'),
                                  TextField(
                                    decoration: InputDecoration(
                                      //hintText: itemT,
                                      labelText: itemT,
                                    ),
                                    controller:
                                    controller, //TextEditingController(text: itemT),//controller,
                                  ),
                                  const Text('Make task bold'),
                                  // controller: controller,
                                  Switch(
                                    value: _switchVal,
                                    onChanged: (bool value) {
                                      dev.log('current switch value: $value');

                                      // setState(() => _switchVal = value);
                                      setState(() {
                                        _switchVal = value;
                                        itemB = !itemB;
                                        //flag = true;
                                        //getItems();
                                        dev.log(
                                            'Switch changed current boldness item to $itemB');
                                        updateUI();
                                      });
                                    },
                                  ),
                                  const Text('Delete your task forever '),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await DatabaseHelper.instance
                                          .delete(int.parse(itemID));
// TODO deletion does not show on the UI

                                      setState(() {
                                        dev.log(
                                            'Flag set to true and getItems() called to reset list to show deleteness change');
                                        _items.removeAt(index);
                                        updateUI();
                                        // newList = _items;
                                        // flag == true;
                                        // getItems();
                                        _showSnack;
                                      });

                                      //   setState(() {
                                      //     dev.log('Item to delete is at index: $index');
                                      //     //_items.removeAt(index);
                                      //     //_items.removeAt(index);
                                      //     dev.log('Delete item at object index ${int.parse(itemID)} ');
                                      //     //  _items.remove(_items.elementAt(index));//which removes the first occurrence of the given element from the list
                                      //     flag = true;
                                      //
                                      //     //_items.remove(_items.)
                                      //     _items.removeAt(index); //To remove an item from a list at a specific index, you should use the removeAt() method of the List class, which removes the element at the given index and returns it Remove item at index
                                      //    //getItems(flag);
                                      //    // _items.removeWhere((item) => item == _items[index]); // Remove item equal to item at index
                                      //
                                      //     // Rung rung = Rung(
                                      //     //     rungId: itemID,
                                      //     //     name: controller.text.trim(),
                                      //     //     done: false,
                                      //     //     boldTitle: false,
                                      //     //     info: '');
                                      //   });
                                      //   // setState(() => Rung.myList.removeAt(int.parse(itemID)));
                                      //   // setState(() => Rung.myList =
                                      //   //     List.from(Rung.myList)..removeAt(1));
                                      //   // setState(() =>
                                      //   //     Rung.myList = List.from(Rung.myList)
                                      //   //       ..removeAt(int.parse(itemID)));
                                      //   // var element = Rung.myList
                                      //   //     .elementAt(int.parse(itemID));
                                      //
                                      //   // dev.log(
                                      //   //'Removed item exist in current list?: ${Rung.myList.contains(element)} Element name: ${element.name}');
                                      //
                                      //   _showSnack;
                                      //   // await Navigator.of(context).pop();
                                      //   // const CloseButton();
                                    },
                                    child: const Icon(
                                        Icons.restore_from_trash_outlined),
                                  ),
                                ],
                              );
                            },
                          ),
                          actions: [
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.of(context).pop();
                            //   },
                            //   child: const Text("Close"),
                            // ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                mainCardWidget(context);
                              },
                              child: const Text("X"),
                            ),

                            ElevatedButton(
                              onPressed: () async {
                                // if (controller.text.isEmpty) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text('Field cannot be empty'),
                                //     ),
                                //   );
                                // } else {}

                                if (itemD == false) {
                                  itemDno = 0;
                                } else {
                                  itemDno = 1;
                                }

                                if (_switchVal == false) {
                                  itemBno = 0;
                                } else {
                                  itemBno = 1;
                                }

                                item.boldTitle = _switchVal;
                                item.done = itemD;

                                // ReCase rc = new ReCase('Just_someSample-text');
                                // print(rc.camelCase); // Prints 'justSomeSampleText'

                                item.rungId = itemID;
                                if (controller.text == '') {
                                  //    ReCase r = ReCase(itemT);
                                  // item.name = r.camelCase;// TODO camel case
                                  dev.log(
                                      'Edit text left empty so old value camelcase restored ${item.name}');
                                } else {
                                  item.name = controller.text;
                                }

                                // Do something when the user submits the form
                                dev.log(
                                    'updated edit task db itemId: $itemID colTask: ${item.name} colBold: $itemBno colDone: $itemDno colInfo: $itemI');
                                await DatabaseHelper.instance.update({
                                  DatabaseHelper.colId: itemID,
                                  DatabaseHelper.colTask: item.name,
                                  DatabaseHelper.colBold: itemBno,
                                  DatabaseHelper.colDone: itemDno,
                                  DatabaseHelper.colInfo: itemI,
                                } //where: '${DatabaseHelper.colId} = ?', whereArgs: [itemI]);
                                );

                                // dev.log(
                                //       'Flag set to true and getItems() called to reset list to show boldness change');
                                // newList = _items;
                                //flag == true;
                                // getItems();

                                dev.log(
                                    'Edit task: $itemID/ ${item.name} /$_switchVal /$itemD');
                                //TODO Update not add to db & update the screen
                                // initState();
                              },
                              child: const Text("Submit"),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Do something when the user submits the form
                                dev.log('Floating action : retrieve tasks');
                                var dbquery = await DatabaseHelper.instance
                                    .queryDatabase();
                                //print(dbquery);
                                dev.log('Query db: $dbquery');
                                //const MyCustomUI();
                              },
                              child: const Text("db"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },

              child: Container(
                //padding: const EdgeInsets.all(10.0),
                // padding: EdgeInsets.all(w / 40),
                //margin: EdgeInsets.fromLTRB(w / 20, w / 20, w / 20, w / 20),
                //height: w / 5,
                decoration: BoxDecoration(
                  color: item.done
                      ? const Color(0xFFA5D6A7)
                      : const Color(0xFFD6D6D6),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.04), blurRadius: 30),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: 40.0,
                        margin: const EdgeInsets.only(left: 20),
                        //alignment: Alignment.centerLeft,
                        // color: Colors.orange,
                        //width: w/ 2.8,
                        child: Center(
                          child: Text(
                            item.name,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: item.boldTitle ? f * 20 : f * 18,
                              //f * 20,
                              fontWeight: item.boldTitle
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.black.withOpacity(.8),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          height: 40.0,
                          margin: const EdgeInsets.only(right: 20),
                          //color: Colors.green,
                          //alignment: Alignment.centerRight,
                          child: Visibility(
                              visible: item.info != "",
                              child: IconButton(
                                icon: const Icon(Icons.info_outline_rounded),
                                onPressed: () {
                                  Navigator.pushNamed(context, item.info);
                                }, //onPressed
                              ))),
                    ],
                  ),
                ),
              ),

              //     // image: DecorationImage(
              //                 //     //     image: AssetImage(image), fit: BoxFit.cover),
              //                 //   ),
              //                 //   child: const Center(
              //                 //     child: Text(
              //                 //       'Tick image',
            ),

            // onNotification: (ScrollNotification scrollNotification) {
            //   if (scrollNotification is ScrollStartNotification) {
            //     dev.log('Widget has started scrolling', name: 'mainwidget()');
            //   }
            //   return true;
            // },
            // );
          ),
        ),
      ),
    );
  }

  Widget cardWithInfoPage2(item, BuildContext context, index) {
    return cardWidget2(context, infoPage(item.name, context), item, index);
  }

  Widget cardWidget2(BuildContext context, Widget route, item, index) {
    double w = MediaQuery.of(context).size.width;
    double f = MediaQuery.of(context).textScaleFactor;

    return SizedBox(
      child: Container(
        //color: Colors.lightBlueAccent,
        child: ReorderableDragStartListener(
          index: index,
          child: InkWell(
            enableFeedback: true,
            // splashColor: Colors.blueGrey,
            // highlightColor: Colors.purple,
            child: Container(
              decoration: BoxDecoration(
                color: item.done
                    ? const Color(0xFFA5D6A7)
                    : const Color(0xFFD6D6D6),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.04), blurRadius: 30),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              // margin: EdgeInsets.fromLTRB(w / 20, w / 20, w / 20, w/20),
              // height: w / 8,
              // padding: EdgeInsets.all(w / 25),
              child: StatefulBuilder(
                builder: (BuildContext context,
                    void Function(void Function()) setState) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 40.0,
                          //alignment: Alignment.centerLeft,
                          //color: Colors.orange,
                          //width: w/ 2.8,
                          child: Center(
                            child: Text(
                              item.name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: item.boldTitle ? f * 20 : f * 18,
                                //f * 20,
                                fontWeight: item.boldTitle
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.black.withOpacity(.8),
                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //     height: 40.0,
                        //     margin: const EdgeInsets.only(right: 20),
                        //       color: Colors.green,
                        //     //alignment: Alignment.centerRight,
                        //     child: Visibility(
                        //         visible: item.info != "",
                        //         child: IconButton(
                        //           icon: const Icon(Icons.info_outline_rounded),
                        //           onPressed: () {
                        //             Navigator.pushNamed(context, item.info);
                        //           }, //onPressed
                        //         ))),
                        // Container(
                        //     height: 40.0,
                        //     margin: const EdgeInsets.only(right: 20),
                        //     // color: Colors.pink,
                        //     //alignment: Alignment.centerRight,
                        //
                        //     child: IconButton(
                        //       icon: const Icon(Icons.delete_sweep),
                        //       onPressed: () {
                        //         //Navigator.pushNamed(context, item.info);
                        //         //TODO Delete from db
                        //
                        //         int id = int.parse(item.rungId);
                        //         dev.log('This item ID is $id');
                        //         DatabaseHelper.instance.delete(id);
                        //         Rung.myList.remove(item.rungId);
                        //         dev.log(
                        //             "rung ${item.rungId} removed from both db and object list ");
                        //       }, //onPressed
                        //     )),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget infoPage(String name, BuildContext context) {
    double f = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Back',
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.black.withOpacity(.7),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.maybePop(context);
          },
        ),
        shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
        elevation: 20,
        backgroundColor: Colors.white,
        title: Text(
          name,
          style: TextStyle(
            color: Colors.black.withOpacity(.7),
            fontSize: f * 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black.withOpacity(.7),
            tooltip: 'Settings info page',
            enableFeedback: true,
            icon: const Icon(Icons.settings),
            //icon: const Icon(CupertinoIcons.gear_altfill),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget deleteCardWidget(BuildContext context) {
    return ListView(
      physics:
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: _getRemovedListItems(),
    );
  }

  void loadRungObjPrefs(String rungId) {
    dev.log('loadRungObjPrefs key rungId : $rungId');
    rungObjIndex = prefs?.getInt(rungId) ?? 0;
  }

  //TODO this is to reorderable list code and how to order my object on my listview in the order of this index?
  Future<void> setRungObjPrefs(String rungId, int index) async {
    dev.log('setRungObjPrefs key: $rungId and index: $index');
    await prefs?.setInt(rungId, index);
  }
}