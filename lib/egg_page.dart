import 'package:demo_1/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'egg_service.dart';

class EggPage extends StatelessWidget {
  const EggPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Egg List'),
      ),
      body: FutureBuilder<ListNestResponse>(
        future: fetchEggs(appState.token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.data.nest.isEmpty) {
            return Center(child: Text('No eggs found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data.nest.length,
              itemBuilder: (context, index) {
                final egg = snapshot.data!.data.nest[index];
                return ListTile(
                  title: Text('Egg ID: ${egg.id}'),
                  subtitle: Text('Status: ${egg.status}, Type: ${egg.typeEgg}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
