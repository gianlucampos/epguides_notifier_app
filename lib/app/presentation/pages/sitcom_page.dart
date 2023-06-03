import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_bloc.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_event.dart';
import 'package:epguides_notifier_app/app/presentation/bloc/sitcom/sitcom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SitcomPage extends StatelessWidget {
  SitcomPage({super.key});

  final bloc = Modular.get<SitcomBloc>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String sitcomValue = '';
    bloc.add(LoadSitcomsEvent());

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Epguides Notifier App'),
          actions: [
            IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bloc.add(AddSitcomEvent(sitcomValue));
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
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
                  return const Center(child: CircularProgressIndicator());
                }
                final list = (state as SucessSicomState).list;
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final sitcom = list[id];
                      return ListTile(
                        leading: sitcom.isReleased
                            ? const CircleAvatar(
                                backgroundColor: Colors.green)
                            : const CircleAvatar(
                                backgroundColor: Colors.red),
                        title: Text(sitcom.name),
                        subtitle: Text(
                            "Release Date: ${sitcom.lastEpisode.releaseDate}"),
                        onTap: () => Modular.to
                            .pushNamed('/episodes', arguments: sitcom.name),
                        onLongPress: () => bloc.add(RemoveSitcomEvent(sitcom)),
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}
