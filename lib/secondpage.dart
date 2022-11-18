import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondPage extends StatefulWidget {
  SecondPage({required this.id});
  String id='';


  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String str='';

  @override
  Widget build(BuildContext context) {

    return Scaffold( backgroundColor: Colors.black,
    appBar: AppBar(
    title: Text("Cast"),
    ),
    body: SingleChildScrollView(child:
    Column(
      children: [
        FutureBuilder(
        future: api(widget.id.toString()),
        builder: (context, snapshot) {if (snapshot.hasData ) return Column(children:[ for(var item in snapshot.data)new Row(children:[
          Padding(
          padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
          child: Image.network(
            item['person']['image']['original'],height: 150,width: 150,),
        ),Text(item['person']['name'].toString(),
            style: TextStyle(
                fontSize: 30,
                color: Colors.white),)

        ])]);
          else return Container();})
      ],
    )));
  }
}
//
Future api(String id)async {
  final url = Uri.parse(
      "https://api.tvmaze.com/shows/$id/cast");
  final response = await http.get(url);
  print(response.body);
  var json = jsonDecode(response.body);
  return json;
}

//