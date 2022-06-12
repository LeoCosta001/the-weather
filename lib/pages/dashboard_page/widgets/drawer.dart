import 'package:flutter/material.dart';
import 'package:the_weather/http/positionstack_api/positionstack_api_utils.dart';
import 'package:the_weather/http/positionstack_api/positionstack_api_webclient.dart';
import 'package:the_weather/models/positionstack_api/positionstack_api.dart';
import 'package:the_weather/models/positionstack_api/positionstack_location_normalize.dart';
import 'package:the_weather/shared/enums/request_state.dart';

/* ***********************************
** Widget: SearchLocationResultList **
*********************************** */
class DashboardDrawer extends StatefulWidget {
  final Function(PositionstackLocationNormalize selectedLocation) onSelectLocation;

  const DashboardDrawer({
    Key? key,
    required this.onSelectLocation,
  }) : super(key: key);

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final PositionstackApiWebClient _positionstackApiWebClient = PositionstackApiWebClient();

  // Input state
  final TextEditingController _searchInputController = TextEditingController();

  // States
  List<PositionstackApiData>? _positionstackApiData;
  RequestState _requestState = RequestState.initial;

  @override // On close
  void initState() {
    setState(() => _searchInputController.text = '');
    setState(() => _positionstackApiData = null);
    setState(() => _requestState = RequestState.initial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.black.withOpacity(0.8)),
      child: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 80,
              child: DrawerHeader(
                duration: Duration(milliseconds: 350),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'The Weather',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            // Search input
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: TextField(
                controller: _searchInputController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Search location',
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (String inputValue) async {
                  if (inputValue.isNotEmpty) {
                    setState(() => _requestState = RequestState.loading);
                    try {
                      final locationList = await _positionstackApiWebClient.getPositionstackApiData(
                          PositionstackApiWebClientDataOption(query: _searchInputController.text));
                      final locationListNormalized = PositionstackApiUtils()
                          .normalizePositionstackApiData(locationList.data, useLocationNameFilter: inputValue);

                      setState(
                          () => _requestState = locationListNormalized.isEmpty ? RequestState.empty : RequestState.ok);
                      setState(() => _positionstackApiData = locationListNormalized);
                    } catch (error) {
                      setState(() => _requestState = RequestState.error);
                    }
                  } else {
                    setState(() => _positionstackApiData = null);
                    setState(() => _requestState = RequestState.initial);
                  }
                },
              ),
            ),

            SearchLocationResultList(
              requestState: _requestState,
              positionstackApiData: _positionstackApiData,
              onSelectLocation: (selectedLocation) => widget.onSelectLocation(selectedLocation),
            ),
          ],
        ),
      ),
    );
  }
}

/* ***********************************
** Widget: SearchLocationResultList **
*********************************** */
class SearchLocationResultList extends StatefulWidget {
  final Function(PositionstackLocationNormalize selectedLocation) onSelectLocation;
  final List<PositionstackApiData>? positionstackApiData;
  final RequestState requestState;

  const SearchLocationResultList({
    Key? key,
    required this.onSelectLocation,
    required this.requestState,
    this.positionstackApiData,
  }) : super(key: key);

  @override
  State<SearchLocationResultList> createState() => _SearchLocationResultListState();
}

class _SearchLocationResultListState extends State<SearchLocationResultList> {
  @override
  Widget build(BuildContext context) {
    switch (widget.requestState) {
      case RequestState.initial:
        return Container();
      case RequestState.loading:
        return Center(
          child: Column(
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Searching',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      case RequestState.error:
        return const SizedBox(
          height: 24.0,
          child: Center(
            child: Text('Internal error'),
          ),
        );
      case RequestState.empty:
        return const SizedBox(
          height: 24.0,
          child: Center(
            child: Text('Location not found'),
          ),
        );
      case RequestState.ok:
        return ListView.separated(
          shrinkWrap: true,
          itemCount: widget.positionstackApiData!.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 5.0,
              color: Colors.transparent,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            final currentLocation = widget.positionstackApiData![index];
            final PositionstackLocationNormalize locationNormalize =
                PositionstackApiUtils().locationNormalize(currentLocation);

            return ListTile(
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.room,
                    color: Colors.white.withOpacity(0.6),
                  )
                ],
              ),
              title: Text(locationNormalize.title),
              subtitle: Text(locationNormalize.subTitle, style: TextStyle(color: Colors.white.withOpacity(0.7))),
              minLeadingWidth: 20.0,
              tileColor: Colors.white.withOpacity(0.1),
              onTap: () {
                widget.onSelectLocation(locationNormalize);
                Navigator.pop(context);
              },
            );
          },
        );
      default:
        return const SizedBox(
          height: 24.0,
          child: Center(
            child: Text('Unknown error'),
          ),
        );
    }
  }
}
