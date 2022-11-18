import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projectapi/secondpage.dart';
import 'package:projectapi/Thirdpage.dart';
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String id='';
  String TV="";
  String end='';
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),



            "TV Maze"),
      ),
      body: SingleChildScrollView(child: Column(
        children: [  Column(children:[
          TextFormField(
            style: TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: TextStyle(color: Colors.black),
                hintText: 'TV Shows',
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.black)),
            controller: myController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10,10,10),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(Color(0xff44000000))),
              onPressed: (() {
                TV = myController.text;
                myController.text =
                    myController.text;
                setState(() {});
              }),
              child: Text(
                "Search",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ]),FutureBuilder(
    future: api(TV),
    builder: (context, snapshot) {if (snapshot.hasData ) {
      if(snapshot.data['ended']==null)
        end='Not Ended';
      else
        end=snapshot.data['ended'];
      id=snapshot.data['apiid'];
      return Column(children: [

        Text(snapshot.data['name'.toString()], style: TextStyle(
            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),),
        Row(
          children: [
            Image.network(
                snapshot.data['image'],height: 500,width: 600,),

        Container(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start
            ,children: [
               Text("Language: "+snapshot.data["lang"],
                  style: TextStyle(
                    fontSize: 30
                  ),

                ),

              Text("Genre: "+snapshot.data['genre'].join(','),
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text("Status:"+snapshot.data['status'],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text("Premiered:"+snapshot.data['premiered'],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text('Ended: '+end,
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text('Runtime:'+snapshot.data['runtime'].toString(),
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text("Day:"+snapshot.data['day'][0],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text('Time:'+snapshot.data['time'],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Icon(Icons.star,color: Colors.yellow,),Text(snapshot.data['rating'].toString()+"/10")
              ]),
              Text('Country:'+snapshot.data['country'],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
              Text('Timezone: '+snapshot.data['timezone'],
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ],
          ),
        ),
          ],
        ),
        SizedBox.fromSize(
          size: Size(10, 10)
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey
          )
            ,child:
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text('Summary:'+snapshot.data['summary'].replaceAll('<p',"").replaceAll(r'</p',"").replaceAll('<b>',"").replaceAll('</b',"").replaceAll('<p>',"").replaceAll('>',""),
                style: TextStyle(

                    fontSize: 30
                ),
              ),
            )),

        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Color(0xff63666A))),
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>SecondPage(id:id)));
              setState(() {

              });
            }),
            child: const Text(
              "Cast",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Color(0xff63666A))),
            onPressed: (() {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Thirdpage(id:id)));
              setState(() {

              });
            }),
            child: const Text(
              "Crew",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),




        


      ]);
    }else return Container(); }
        )

        ],)
      ),
    );
  }
}
Future api(String tv)async {
  final url = Uri.parse(
      "https://api.tvmaze.com/singlesearch/shows?q=$tv&embed=episodes");
  final response = await http.get(url);

  final json =jsonDecode(response.body);
  final output = {"name": json['name'],'apiid':json['url'].substring(29,31),'summary':json['summary'],'timezone':json['network']['country']['timezone'],'country':json['network']['country']['name'],'rating':json['rating']['average'],'time':json['schedule']['time'],'day':json['schedule']['days'],'runtime':json['runtime'],'ended':json['ended'],'image':json['image']['original'],"lang":json['language'],'genre':json['genres'],'status':json['status'],'premiered':json['premiered']
  };

  return output;
}
//d23e4bbc6dc29e67a34db53172ec7dc1
//'imbd':json['externals']['imbd'],