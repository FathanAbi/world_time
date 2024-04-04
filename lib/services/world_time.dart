import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late bool isDayTime;

  WorldTime({ required this.location, required this.flag, required this.url });

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      String plusOrMinus = data['utc_offset'].substring(0,1);
      DateTime now = DateTime.parse(datetime);
      if(plusOrMinus == '-'){
        now = now.subtract(Duration(hours: int.parse(offset)));
      }else{
        now = now.add(Duration(hours: int.parse(offset)));
      }

      time = DateFormat.jm().format(now);

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;


    }
    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }

  }
}

