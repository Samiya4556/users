import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uresrs/provider/user_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Homeprovider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Contacts",
              style: TextStyle(color: Colors.pink),
            ),
            centerTitle: true,
            leading: const Icon(
              Icons.menu_outlined,
              color: Colors.pink,
            ),
            backgroundColor: Colors.white,
          ),
          body: Builder(builder: (context) {
            var provider = Provider.of<Homeprovider>(context);
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (provider.error.isNotEmpty) {
              return Center(
                child: Text(provider.error),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://source.unsplash.com/random/")),
                    title: Text(provider.data!.get(index)!.name.toString()),
                    trailing: Icon(Icons.call),
                  );
                },
                itemCount: provider.data!.length,
              );
            }
          }),
        );
      },
    );
  }
}