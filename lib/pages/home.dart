import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Map data = {};

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    data = (data?.isEmpty ?? true) ? ModalRoute.of(context)!.settings.arguments as Map : data;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.lightBlue : Colors.indigo[700] as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: <Widget>[
                  ElevatedButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });

                    },
                    label: Text(
                      'edit location',
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
