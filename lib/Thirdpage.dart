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
        body: SingleChildScrollView(child:
        Column(
          children: [
            FutureBuilder(
                future: api(widget.id.toString()),
                builder: (context, snapshot) {if (snapshot.hasData )
                  return Column(children:[ for(var item in snapshot.data) Row(
                    children:[
                      if(item['person']['image']==null)
                        Container(height: 90,width: 50,color: Colors.black,)
                      else
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                          child: Image.network(
                          item['person']['image']['original']
                          ,height: 150,width: 150,),
                        )
                  ,Text(item['person']['name'].toString(),
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white),)])]);
                else return Container();})
          ],
        )));
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