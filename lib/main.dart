import 'dart:async';

import 'package:buyer_app/assistantMethods/address_changer.dart';
import 'package:buyer_app/assistantMethods/total_amount.dart';
import 'package:buyer_app/global/PreferenceHelper.dart';
import 'package:buyer_app/global/notifications.dart';
import 'package:buyer_app/global/route.dart';
import 'package:buyer_app/global/route_generator.dart';
import 'package:buyer_app/mollie_payment/MolliePaymentScreen.dart';
import 'package:buyer_app/providers/CartProvider.dart';
import 'package:buyer_app/providers/DashboardProvider.dart';
import 'package:buyer_app/providers/DishesRestaurantProvider.dart';
import 'package:buyer_app/providers/LoginProvider.dart';
import 'package:buyer_app/providers/OrdersProvider.dart';
import 'package:buyer_app/providers/ProfileProvider.dart';
import 'package:buyer_app/providers/RestaurantProductProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<DashboardProvider>(create: (_) => DashboardProvider()),
  ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
  ChangeNotifierProvider<RestaurantProductProvider>(
      create: (_) => RestaurantProductProvider()),
  ChangeNotifierProvider<DishesRestaurantProvider>(
      create: (_) => DishesRestaurantProvider()),
  ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
  ChangeNotifierProvider<OrdersProvider>(create: (_) => OrdersProvider()),
  ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceHelper.load().then((value) {});

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await NotificationApi.init(initScheduled: true);
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(
        initialRoute: "home",
        routes: {
          "home": (context) => MyApp(),
          "done": (context) => const MolliePaymentScreen(
                isLoading: true,
              )
        },
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            child: child ?? Container(),
            data: data.copyWith(
                textScaleFactor:
                    data.textScaleFactor > 1.0 ? 1.0 : data.textScaleFactor),
          );
        },
        debugShowCheckedModeBanner: false,
        // home: MyApp(),
      ),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getAddress() async {
    Position position = await _getGeoLocationPosition();
    var location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    print(location + "---location");

    await sharedPreferences!
        .setString("latitude", position.latitude.toString());
    await sharedPreferences!
        .setString("longitude", position.longitude.toString());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final postMdl = Provider.of<DashboardProvider>(context, listen: false);
      postMdl.getHomepageDetails(context);
    });
  }

  Future<void> locationPermission() async {
    await Permission.location.isRestricted;
    // await Permission.locationAlways.isRestricted ;
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      checkGps();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }

  Future<void> checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    // await sharedPreferences!.setString("latitude", lat);
    // await sharedPreferences!.setString("longitude", long);

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
      getAddress();
    });
  }

  @override
  void initState() {
    super.initState();
    locationPermission().then((value) {
      checkGps().then((value) {
        getAddress();
      });
    });

    getDeviceToken();
    fcmSubscribe();
  }

  Future<void> fcmSubscribe() async {
    await FirebaseMessaging.instance.subscribeToTopic('broadcast_all');
  }

  getDeviceToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      PreferenceHelper.setString(PreferenceHelper.FCM_TOKEN, token ?? "");
      print("fcm-token $token");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
      ],
      child: MaterialApp(
        title: 'Royal Tokyo Sushi',
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.splashScreen,
        builder: EasyLoading.init(),
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(primarySwatch: Colors.green, useMaterial3: false),
        // home: const MySplashScreen(),
      ),
    );
  }
}
