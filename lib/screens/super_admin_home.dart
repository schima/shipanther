import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipanther/bloc/tenant/tenant_bloc.dart';
import 'package:shipanther/l10n/shipanther_localization.dart';
import 'package:shipanther/screens/tenant/home.dart';
import 'package:shipanther/screens/tenant/list.dart';
import 'package:shipanther/widgets/centered_loading.dart';
import 'package:shipanther/widgets/shipanther_scaffold.dart';
import 'package:trober_sdk/api.dart';

class SuperAdminHome extends StatefulWidget {
  final User user;
  const SuperAdminHome(this.user, {Key key}) : super(key: key);

  @override
  _SuperAdminHomeState createState() => _SuperAdminHomeState();
}

class _SuperAdminHomeState extends State<SuperAdminHome> {
  TenantBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<TenantBloc>();
    bloc.add(GetTenants(null));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TenantBloc, TenantState>(
      listener: (context, state) {
        if (state is TenantFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => Home()));
        }
      },
      builder: (context, state) {
        if (state is TenantsLoaded) {
          return TenantList(widget.user,
              tenantBloc: bloc, tenantLoadedState: state);
        }
        if (state is TenantLoaded) {
          return TenantDetail(tenantBloc: bloc, state: state);
        }
        return ShipantherScaffold(
          widget.user,
          title: ShipantherLocalizations.of(context).tenantsTitle,
          actions: [],
          body: CenteredLoading(),
          floatingActionButton: null,
        );
      },
    );
  }
}
