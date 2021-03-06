import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shipanther/bloc/user/user_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/user/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:trober_sdk/api.dart' as api;

class UserScreen extends StatefulWidget {
  final api.User loggedInUser;

  const UserScreen(this.loggedInUser, {Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<UserBloc>();
    bloc.add(GetUsers(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => UserScreen()));
        }
      },
      builder: (context, state) {
        if (state is UsersLoaded) {
          return UserList(widget.loggedInUser,
              userBloc: bloc, userLoadedState: state);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(ShipantherLocalizations.of(context).usersTitle),
          ),
          body: CenteredLoading(),
        );
      },
    );
  }
}
