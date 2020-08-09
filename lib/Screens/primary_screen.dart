import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:racingApp/Constants/constant.dart';
import 'package:racingApp/Providers/user.dart';
import 'package:racingApp/Screens/EventsScreen.dart/EventsScreen.dart';
import 'package:racingApp/Screens/MapsScreens.dart/map_screen_initializer.dart';
import 'package:racingApp/Widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:racingApp/models/Events.dart';
import 'dart:io';

class PrimaryScreen extends StatefulWidget {
  @override
  _PrimaryScreenState createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {



  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(width, _pixelRatio);
    bool _small = ResponsiveWidget.isScreenSmall(width, _pixelRatio);
    print(width * _pixelRatio);
    print(_pixelRatio);
    print(_large);
    print(_small);
    print(_medium);


    ///Main ui function for screen
    return Material(
      child: Scaffold(
        ///appbar
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Image.asset(
            "assets/logo.png",
            width: 70,
            height: 70,
          ),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, PROFILE);
              },
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  // child: CircleAvatar(
                  //   backgroundImage: AssetImage("assets/logo.png"),
                  // ),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  )),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
            color: Colors.white,
          ),
          height: height,
          width: width,
          child: ListView(
            children: <Widget>[
              // Container(
              //   color: Colors.red,
              //   height: 60,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       SizedBox(
              //         width: 40,
              //       ),
              //       Image.asset("assets/logo.png"),
              //       InkWell(
              //         onTap: () {
              //           Navigator.pushNamed(context, PROFILE);
              //         },
              //         child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             // child: CircleAvatar(
              //             //   backgroundImage: AssetImage("assets/logo.png"),
              //             // ),
              //             child: Icon(
              //               Icons.person,
              //               color: Colors.white,
              //               size: 30,
              //             )),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),

              ///this container contains the live racers heading and
              ///link toe the full map page
              Container(
                color: Colors.black.withOpacity(0.6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "LIVE RACERS",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, FULL_MAP);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "See full map",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              ///This container contains the half screen map on the screen
              Container(
                height: height / 2.3,
                width: width,
                child: ListView(
                  //scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    map(context, width, height),
                  ],
                ),
              ),

              ///Shops section starts here
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "SHOPS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text("See all"),
              Container(
                height: height - ((height / 3.5) + height / 3) - 60,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CAR_SHOP_PAGE);
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/car.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                              child: Center(
                                  child: Container(
                                color: Colors.black.withOpacity(0.6),
                                child: Text(
                                  "CAR & PARTS",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CLOTHES_SHOP_PAGE);
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/clothes.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                // color: Colors.blue.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 200,
                              width: width / 1.5,
                              child: Center(
                                  child: Container(
                                color: Colors.black.withOpacity(0.6),
                                child: Text(
                                  "CLOTHES",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///Events section starts here
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.6),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "EVENTS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                height: height / 3,
                width: width,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('events').orderBy('timestamp',descending: true).snapshots(),
                  builder: (context,AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final snapShotData = snapshot.data.documents;
                    if(snapShotData.length == 0){
                      return Center(child: Text("No products added"),);
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapShotData.length,
                      itemBuilder: (context, index){
                        var eventItem = snapShotData[index].data;
                        return eventsItem(Events(imageUrls: eventItem['eventimages'],
                            date: eventItem['eventdate'],
                            description: eventItem['eventdescription'],
                            id: eventItem['eventid'],
                            title: eventItem['title']
                        ));
                      },
                    );
                  }
                ),
              ),

              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  ///Function creates an event item ui that is then placed in a list
  ///and goes to event screen on tap
  Widget eventsItem(Events event) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventScreen(
                event: event,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(
                Radius.circular(25.0),
              ),
              image: DecorationImage(
                image: NetworkImage(event.imageUrls[0]),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.3),
      ),
    );
  }



  ///THis function the half page ui on the screen
  Widget map(BuildContext context, double screenwidth, double height) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(
                  Radius.circular(20.0),
                )),
            height: height / 2.5,
            width: screenwidth,
            child: MapInitializer()
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    final fbm = FirebaseMessaging();
    if(Platform.isIOS){
      fbm.onIosSettingsRegistered
      .listen((event) { _saveDeviceToken(fbm);});
      fbm.requestNotificationPermissions(
          IosNotificationSettings()
      );
    }else{
      _saveDeviceToken(fbm);
    }

    fbm.configure(
      onMessage: (msg){
        print(msg);

        final snackbar = SnackBar(
          content: Text(msg['notification']['title']),
          action: SnackBarAction(
            label: 'See',
            onPressed: (){},
          ),
        );
        Scaffold.of(context).showSnackBar(snackbar);
        return;
      },
      onLaunch: (msg){
        print(msg);
        return;
      },
      onResume: (msg){
        print(msg);
        return;
      },

    );
    fbm.subscribeToTopic('chat');
    super.initState();
  }

  _saveDeviceToken(var fbm)async{
    //UserModel user = Provider.of<User>(context).userProfile;

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String fcmtoken = await fbm.getToken();
    if (fcmtoken != null){
      await Firestore.instance.collection("Users")
          .document(user.uid)
          .collection('tokens')
          .document(fcmtoken)
          .setData({
        'token' : fcmtoken,
        'createdAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem
      });
    }
  }
}
