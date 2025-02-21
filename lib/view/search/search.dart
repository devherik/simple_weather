import 'package:flutter/material.dart';
import 'package:simple_weather_app/viewmodel/weather_viewmodel.dart';
import 'package:simple_weather_app/view/detailed/detailed.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required WeatherViewmodel viewmodel})
      : _viewmodel = viewmodel;
  final WeatherViewmodel _viewmodel;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _searchTextController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: TextFormField(
            focusNode: FocusNode(),
            autofocus: true,
            controller: _searchTextController,
            maxLines: 1,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                hintText: 'Digite uma cidade ou local',
                hintStyle: Theme.of(context).textTheme.labelLarge)),
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: widget._viewmodel
                  .fetchWeatherByCity(_searchTextController.text.trim()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DetailedPage(
                    parentContext: context,
                    weatherData: snapshot.data,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
