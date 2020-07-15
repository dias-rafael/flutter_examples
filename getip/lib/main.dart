import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get_ip/get_ip.dart';

import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _ip = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    /*
    try {
      const url = 'https://api.ipify.org';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // The response body is the IP in plain text, so just
        // return it as-is.
        if (!mounted) return null;

        setState(() {
          _ip = response.body.toString();
        });
      } else {
        // The request failed with a non-200 code
        // The ipify.org API has a lot of guaranteed uptime 
        // promises, so this shouldn't ever actually happen.
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      // Request failed due to an error, most likely because 
      // the phone isn't connected to the internet.
      print(e);
      return null;
    }
    */
    /*
    try {
      const url = 'http://ip-api.com/json';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // The response body is the IP in plain text, so just
        // return it as-is.
        if (!mounted) return null;

        setState(() {
          _ip = jsonDecode(response.body)['query'].toString();
        });
      } else {
        // The request failed with a non-200 code
        // The ipify.org API has a lot of guaranteed uptime 
        // promises, so this shouldn't ever actually happen.
        print(response.statusCode);
        print(response.body);
        return null;
      }
    } catch (e) {
      // Request failed due to an error, most likely because 
      // the phone isn't connected to the internet.
      print(e);
      return null;
    }
*/
    
    String ipAddress;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ipAddress = await GetIp.ipv6Address;// .ipAddress;
    } on PlatformException {
      ipAddress = 'Failed to get ipAdress.';
    }

    if (!mounted) return;

    setState(() {
      _ip = ipAddress;
    });

  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('IP Example app'),
        ),
        body: new Center(
          child: new Text('Running on: $_ip\n'),
        ),
      ),
    );
  }
}