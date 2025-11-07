// ignore_for_file: avoid_print, unused_field

import 'dart:async';
//import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import 'package:smart_building/HomeUI.dart'; 
import 'package:awesome_notifications/awesome_notifications.dart';

void main() {
    AwesomeNotifications().initialize(null,
      [NotificationChannel(channelKey: "basic_channel", channelName: 'Basic notofications', channelDescription: 'Notification channel for basic tests')]
      , debug: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<BluetoothDevice> _devices = [];
  late BluetoothConnection connection;
  String adr = "98:D3:21:F8:43:27"; // my bluetooth device MAC Adres
  String recData = "";
  String receivedData = "---";
  double humidity = 99;
  double temperature = 0;
  double gasLevel =0 ;
  double smokeLevel =0 ;
  String quality = "";
    String smquality = "";

  late Timer _timer;
  String _timeString = "";

  @override
  void initState() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
      });
    // _startTimer();  automatic
    super.initState();
    _loadDevices();
    
  }


  Future<void> _loadDevices() async {
    List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance
        .getBondedDevices();

    setState(() {
      _devices = devices;
    });
  }

triggerNotificationGas(){
  AwesomeNotifications().createNotification(content: NotificationContent(id: 10, 
  channelKey: 'basic_channel',
  title: "Smart Buildiing Gas Warning",
  body:"The gases concentration in your building is High"
  ));
}
triggerNotificationSmoke(){
  AwesomeNotifications().createNotification(content: NotificationContent(id: 10, 
  channelKey: 'basic_channel',
  title: "Smart Buildiing Smoke Warning",
  body:"The smoke concentration in your building is High"
  ));
}
  //----------------------------
  Future<void> sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      connection.output.add(bytes);
      await connection.output.allSent;
      if (kDebugMode) {
        print('Data sent successfully');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // data RECEIVED --------------

   receiveData() async {
    connection.input!.listen((Uint8List data) {

receivedData = String.fromCharCodes(data);
      if (receivedData.startsWith('r')) {
        // Process humidity data
        setState(() {
          int integerPart = data[1];
        int decimalPart = data[2];
         temperature = integerPart + decimalPart / 100.0;
                print('Temprature: $temperature');
// Temprature recieved !

                 int integerrPart = data[3];
        int decimallPart = data[4];
         humidity = integerrPart + decimallPart / 100.0;
                print('humidity: $humidity');
// Humidity recieved !

int integerrrPart = data[5];
  int decimalllPart = data[6];
  gasLevel = integerrrPart + decimalllPart / 100.0;
   print('gas level: $gasLevel');

                
  if (gasLevel < 20.0) {
    setState(() {
      quality  = "good";

    });
  } 
  else if (gasLevel > 20.0 && gasLevel < 30.0) {
     setState(() {
      quality  = "poor";
       triggerNotificationGas();

    });
  }
   else if (gasLevel > 30.0 && gasLevel < 40.0) {
    setState(() {
      quality  = "Very Bad";
      triggerNotificationGas();
    });
  }
   else if (gasLevel > 40.0 && gasLevel < 50.0) {
 setState(() {
      quality  = "Very Toxic";
      triggerNotificationGas();
    });
      } else {
 setState(() {
      quality  = "Toxic";
            triggerNotificationGas();

    });  
    }
 // Gas level recieved !

        int integerrrrPart = data[7];
        int decimallllPart = data[8];
         smokeLevel = integerrrrPart + decimallllPart / 100.0;
                print('smoke level: $smokeLevel');
          if (smokeLevel < 37.0) {
            setState(() {
            smquality = "Low!";
            });
   } else if(smokeLevel> 37.0 && smokeLevel< 50.0){
    setState(() {
          smquality = "Moderate!";
    });
   } else if (smokeLevel >50.0){
    setState(() {
          triggerNotificationSmoke();
    smquality = "high";
    });
  // Smoke level recieved!
    }
  });
 }
  else{print("data recieving");}
    });

  //--------------------------------------
   }
// TIMER START-----------
  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
    
      

    });
  }

  // TIMER STOP--------------------------------------
  Future<void> _stopTimer() async {
    setState(() {
    });
    _timer.cancel();
  }

//---------------------------------------------

void _openMyPage() {
  Navigator.pop(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) =>  HomeUI(humidity: humidity,temperature: humidity ,gasLevel: gasLevel,quality: quality, smokeLevel: smokeLevel, smquality: smquality,),
    ),
  );
}


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("21207 Smart Building"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("MAC Adress: 00:22:04:00:5E:F6"),

                ElevatedButton(child: const Text("Connect"), onPressed: () {
                  connect(adr);
                },),

                const SizedBox(height: 30.0,),

                const Text("Sensors data: ",style: TextStyle(fontSize: 37.0),),
                Text("$temperature",style: const TextStyle(fontSize: 18),),

                const SizedBox(height: 10.0,),
                Text("$humidity",style: const TextStyle(fontSize: 18),),

                // Text(_timeString),
                const SizedBox(height: 10.0,),

                
                const SizedBox(height: 10.0,),
                // ElevatedButton(onPressed: receiveData, child: Text("button"))

                Builder(
        builder: (context) => ElevatedButton(
              onPressed: () {
                receiveData();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(
                        builder: (context) => HomeUI(humidity: humidity,temperature: temperature, gasLevel: gasLevel,quality:quality,
                        smokeLevel: smokeLevel, smquality: smquality,)));
              },
              child: const Text('Display Data'),
            ),
      ),

              ],
            ),
          ),

        )

    );
  }
  

  Future connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      // sendData('111');
      //durum="Connected to the device";

    } catch (exception) {
      // durum="Cannot connect, exception occured";
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }

// --------------**************data gonder
//Future send(Uint8List data) async {
//connection.output.add(data);
// await connection.output.allSent;
// }

}
//------------*********** data gonder end

