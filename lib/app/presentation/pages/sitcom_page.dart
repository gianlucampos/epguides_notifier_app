import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SitcomPage extends StatelessWidget {
  SitcomPage({super.key});

  final bloc = Modular.get<SitcomBloc>();

  @override
  Widget build(BuildContext context) {
    String sitcomValue = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epguides Notifier App'),
        actions: [
          IconButton(
              onPressed: () => bloc.add(AddSitcomEvent(sitcomValue)),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Search..."),
              onChanged: (value) {
                sitcomValue = value;
              },
            ),
          ),
          Expanded(
              child: StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {
              final state = bloc.state;
              if (state is StartSicomState) {
                return const Center(
                  child: Text("Type something here"),
                );
              }
              if (state is ErrorSicomState) {
                return const Center(
                  child: Text("Error"),
                );
              }
              if (state is LoadingSicomState) {
                return const CircularProgressIndicator();
              }
              final list = (state as SucessSicomState).list;
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, id) {
                    final sitcom = list[id];
                    return ListTile(
                      leading: Text("${sitcom.isReleased}"),
                      title: Text(sitcom.name),
                      subtitle: Text(
                          "Release Date: ${sitcom.lastEpisode.releaseDate}"),
                    );
                  });
            },
          ))
        ],
      ),
    );
  }
}
