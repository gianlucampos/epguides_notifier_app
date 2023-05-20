import 'package:epguides_notifier_app/features/consultApi/presentation/manager/search_bloc.dart';
import 'package:epguides_notifier_app/features/consultApi/presentation/manager/states/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EpisodesInfoPage extends StatefulWidget {
  const EpisodesInfoPage({Key? key}) : super(key: key);

  @override
  State<EpisodesInfoPage> createState() => _EpisodesInfoPageState();
}

class _EpisodesInfoPageState extends State<EpisodesInfoPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epguides Notifier App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: TextField(
              onChanged: bloc.add,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Search..."),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is SearchStart) {
                    return const Center(
                      child: Text("Type something here"),
                    );
                  }
                  if (state is SearchError) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is SearchLoading) {
                    return const CircularProgressIndicator();
                  }
                  final list = (state as SearchSucess).list;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final episode = list[id];
                        return ListTile(
                          leading:
                              Text("${episode.season} X ${episode.number}"),
                          title: Text(episode.title),
                          subtitle:
                              Text("Release Date: ${episode.releaseDate}"),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
