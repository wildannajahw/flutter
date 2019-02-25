import 'package:flutter/material.dart';
import 'package:flutter1/pokemon.dart';
import 'package:flutter1/pokemondetail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main()=>runApp(MaterialApp(
  title: 'Pokemon',
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));
class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  var url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeHub pokeHub;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }
  fetchData() async{
    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    pokeHub = PokeHub.fromJson(decodedJson);
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: Text('Pokemon'),
        backgroundColor: Colors.cyan,
      ),
      body: pokeHub == null
      ? Center(child: CircularProgressIndicator(),)
      :GridView.count(
        crossAxisCount: 2,
        children: pokeHub.pokemon
          .map((poke) =>Padding(
            padding:const EdgeInsets.all(8),
            child:InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PokeDetail(
                  pokemon: poke,
                )));
            },
            child: Hero(
              tag: poke.img,
              child: Card(
                elevation: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(poke.img),
                        )
                      ),
                    ),
                    Text(poke.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                  ),
              ),
            ),
          ),
        ))
        .toList(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}