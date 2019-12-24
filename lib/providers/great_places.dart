import 'package:flutter/foundation.dart';
import '../models/place.dart';
import 'dart:io';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  // ChangeNotifier allow us to update with notifylisten

  List<Place> _items = [];

  List<Place> get items {
    // this getter : other files can have access to this
    // without updating
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((item)=> Place(
      id: item['id'],
      title: item['title'],
      image: File(item['image']),
      location: null
    )).toList();
    notifyListeners();
  }
}
