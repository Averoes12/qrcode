import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_app/pages/auth/bloc/auth_bloc.dart';
import 'package:qrcode_app/pages/freetogame/provider/game_provider.dart';

import '../../models/game/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GameProvider>().fetchLiveGame();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Live Game"),
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if(gameProvider.status == GameStatus.loading){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(gameProvider.status == GameStatus.error){
            return const Center(child: Text("Something wrong occurred, Please try again later"),);
          }

          List<Game> games = gameProvider.games;

          print(games);
          return GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2
            ),
            itemBuilder: (context, index){
              Game game = games[index];
              print(game.thumbnail);
              return Image.network(
                game.thumbnail ?? "",
                errorBuilder: (context, a, _) => const Icon(Icons.broken_image),
                loadingBuilder: (context, a, _) => const SizedBox(height: 50, width: 50, child: CircularProgressIndicator(),),

              );
            },
          );
        },
      ),
    );
  }
}
