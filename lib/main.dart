import 'package:flutter/material.dart';
import 'package:greate_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import './providers/great_places.dart';
import './screens/places_list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
          child: MaterialApp(
        title: "Greate Places",
        theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.indigo
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(ctx) => AddPlaceScreen(),
        }
        

        
      ),
    );
  }
}