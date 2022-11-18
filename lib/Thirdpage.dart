import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Thirdpage extends StatefulWidget {
  Thirdpage({required this.id});
  String id='';


  @override
  State<Thirdpage> createState() => _ThirdpageState();
}

class _ThirdpageState extends State<Thirdpage> {
  String str='';

  @override
  Widget build(BuildContext context) {

    return Scaffold( backgroundColor: Colors.black,
    appBar: AppBar(
    title: Text("Crew"),
    ),
        body: Column(
          children: [
            FutureBuilder(
                future: api(widget.id.toString()),
                builder: (context, snapshot) {if (snapshot.hasData )
                  return Column(children:[ for(var item in snapshot.data) Row(
                    children:[
                      if(item['person']['image']==null)
                        Container(height: 30,width: 30,color: Colors.black,)
                      else
                        Image.network(
                        item['person']['image']['original']
                        ,height: 30,width: 30,)
                  ,Text(item['person']['name'].toString(),style: TextStyle(color: Colors.white),)])]);
                else return Container();})
          ],
        ));
  }
}
//
Future api(String id)async {
  final url = Uri.parse(
      "https://api.tvmaze.com/shows/$id/crew");
  final response = await http.get(url);
  print(response.body);
  var json = jsonDecode(response.body);
  return json;
}

//