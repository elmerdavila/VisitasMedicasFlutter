

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value){
    runApp(MyApp());
  });
 
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class Paciente{
  late String full_name;
  late String born_date;
  late String address;
  late String gps;
  late double height_cm;
  late double pressure;
  late double saturation;
  late double temperature;
  late double weight_kg;

}
class _MyHomePageState extends State<MyHomePage> {

  String fullname="";
  double height=0;
  String address="";
  double latitude =0;
  double longitude =0;

  double peso=0;
  double temperature=0;
  double presion=0;
  double saturacion=0;

  GlobalKey formkey= GlobalKey<FormState>();

  TextEditingController TECfullname= new TextEditingController();
  TextEditingController TECheight= new TextEditingController();
  TextEditingController TECaddress= new TextEditingController();
  TextEditingController TEClatitude= new TextEditingController();
  TextEditingController TEClongitude= new TextEditingController();

  TextEditingController TECpeso= new TextEditingController();
  TextEditingController TECtemperatura= new TextEditingController();
  TextEditingController TECpresion= new TextEditingController();
  TextEditingController TECsaturacion= new TextEditingController();
  @override
  void initState(){
    super.initState();
    getPacientes();
  }

  void getCurrentLocation ()async {
    var position = await Geolocator()!.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print("$position.latitude , $position.longitude");
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }
  Future getPacientes() async {
    var firestore= FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("pacientes").get();
    return qn;
  }

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> showDialogForm(BuildContext context) async{
    return await showDialog(
        context: context,
        builder: (context){
          final TextEditingController _nameController = TextEditingController();
          return AlertDialog(
            content: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: TECfullname,
                      decoration: InputDecoration(labelText: "nombre completo"),
                      onSaved:(value){
                        fullname = value!.isNotEmpty?value:"";
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese el nombre";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECheight,
                      decoration: InputDecoration(labelText: "estatura"),
                      onSaved:(value){
                        height = double.parse(value!);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese la estatura";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECaddress,
                      decoration: InputDecoration(labelText: "Dirección"),
                      onSaved:(value){
                        address = value!.isNotEmpty?value:"";
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese la dirección";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECpeso,
                      decoration: InputDecoration(labelText: "peso"),
                      onSaved:(value){
                        peso= double.parse(value!);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese peso";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECtemperatura,
                      decoration: InputDecoration(labelText: "Temperatura"),
                      onSaved:(value){
                        temperature= double.parse(value!);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese la temperatura";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECpresion,
                      decoration: InputDecoration(labelText: "Presion"),
                      onSaved:(value){
                        presion = double.parse(value!);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese la presion";
                        }
                      },
                    ),
                    TextFormField(
                      controller: TECsaturacion,
                      decoration: InputDecoration(labelText: "Saturacion"),
                      onSaved:(value){
                        saturacion = double.parse(value!);
                      },
                      validator: (value){
                        if(value!.isEmpty){
                          return "ingrese la saturacion";
                        }
                      },
                    ),
                    Text("latitude: $latitude"),
                    Text("longitude: $longitude")
                  ],
                )
            ),
            actions: <Widget>[
              TextButton(
                  child: Text("Agregar Visitante"),
                  onPressed:(){
                    Map <String, dynamic> data = {
                      "full_name": TECfullname.text,
                      "address": TECaddress.text,
                      "height_cm": TECheight.text,
                      "pressure":TECpresion,
                      "saturation":TECsaturacion,
                      "temperature":TECtemperatura,
                      "weight_kg":TECpeso

                    };
                    FirebaseFirestore.instance.collection("pacientes").add(data);
                    Navigator.of(context).pop();
                  },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Visitas Medicas"),
        centerTitle: true,
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async{
            getCurrentLocation();
            await showDialogForm(context);
          },
        ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pacientes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return ListView.builder(
          itemCount: streamSnapshot.data!.docs.length,
          itemBuilder: (ctx, index) =>
          ListTile(
            title:Text(streamSnapshot.data!.docs[index]['full_name']),
            subtitle:Text(streamSnapshot.data!.docs[index]['address']),
          )
              );
        }
    )
    );
    }
}
