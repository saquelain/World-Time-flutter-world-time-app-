import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime {

  late String location;  //location name for the UI
  late String time; //time in that location
  late String flag; //url to an asset flag icon
  late String url; // location url for api endpoint
  bool isDaytime = false; //is day time or not

  WorldTime({required this.location, required this.flag, required this.url});



  Future<void> getTime() async {

    try {
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //print(data);
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);
      String offsetSeconds = data['utc_offset'].substring(4,6);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offsetSeconds)));
      // print(now);
      //set the time property

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      //print(time);
    }
    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }



  }
}

//WorldTime instance = WorldTime(location: 'Berlin', flag: 'Germany', url: 'Europe/Berlin');