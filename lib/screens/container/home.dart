import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/container/container_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/container/list.dart';

import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart' as api;

class ContainerScreen extends StatefulWidget {
  final api.User loggedInUser;
  ContainerScreen(this.loggedInUser);
  @override
  _ContainerScreenState createState() => _ContainerScreenState();
}

class _ContainerScreenState extends State<ContainerScreen> {
  ContainerBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<ContainerBloc>();
    bloc.add(GetContainers());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContainerBloc, ContainerState>(
      listener: (context, state) {
        if (state is ContainerFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        if (state is ContainerLoaded) {
          return Container(
            child: Text('container loaded'),
          );
        }
        if (state is ContainersLoaded) {
          return ContainerList(widget.loggedInUser,
              containerBloc: bloc, containerLoadedState: state);
        }
        return ShipantherScaffold(
          widget.loggedInUser,
          title: ShipantherLocalizations.of(context).containersTitle,
          actions: [],
          body: CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
