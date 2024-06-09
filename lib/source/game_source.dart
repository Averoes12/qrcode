import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qrcode_app/models/game/game.dart';
import 'package:http/http.dart' as http;

class GameSource {
  static Future<List<Game>?> getLiveGame() async{
    String url  = "https://www.freetogame.com/api//games";
    final response = await http.get(Uri.parse(url));
    try {
      if(response.statusCode == 200){
        List list = jsonDecode(response.body);
        return list.map((e) => Game.fromJson(Map.from(e))).toList();
      } else {
        return null;
      }
    } catch (e){
      debugPrint(e.toString());
      return null;
    }

  }
}