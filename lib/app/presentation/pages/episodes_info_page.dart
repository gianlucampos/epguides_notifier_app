import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/search_episode/search_episode_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EpisodesInfoPage extends StatelessWidget {
  EpisodesInfoPage({Key? key}) : super(key: key);

  final bloc = Modular.get<SearchEpisodeBloc>();
  final sitcomName = Modular.args.data;

  @override
  Widget build(BuildContext context) {
    bloc.add(LoadSearchEpisodeEvent(searchText: sitcomName));
    return Scaffold(
      appBar: AppBar(
        title: Text(sitcomName),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
          //   child: TextField(
          //     onChanged: (value) {
          //       bloc.add(LoadSearchEpisodeEvent(searchText: value));
          //     },
          //     decoration: const InputDecoration(
          //         border: OutlineInputBorder(), labelText: "Search..."),
          //   ),
          // ),
          Expanded(
            child: StreamBuilder(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;
                  if (state is SearchEpisodeStartState) {
                    return const Center(
                      child: Text("Type something here"),
                    );
                  }
                  if (state is SearchEpisodeErrorState) {
                    return const Center(
                      child: Text("Error"),
                    );
                  }
                  if (state is SearchEpisodeLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final list = (state as SearchEpisodeSucessState).list;
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (_, id) {
                        final episode = list[id];
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                              backgroundColor: Colors.white,
                              child: Text(
                                  "${episode.season} X ${episode.number}")),
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
