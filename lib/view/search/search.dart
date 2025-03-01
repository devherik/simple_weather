import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simple_weather_app/main.dart';
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
                  if (snapshot.data!.cityName == 'Empty') {
                    return emptySearchImage();
                  } else {
                    return DetailedPage(
                      parentContext: context,
                      weatherData: snapshot.data,
                    );
                  }
                } else {
                  return emptySearchImage();
                }
              }),
        ),
      ),
    );
  }

  Widget emptySearchImage() {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
              MyApp.of(context)!.viewmodel.value.theme == ThemeMode.dark
                  ? 'assets/images/undraw/location-search_white.svg'
                  : 'assets/images/undraw/location-search_green.svg',
              height: 200,
              width: 200),
          const SizedBox(height: 16),
          Text('Nenhum resultado encontrado',
              style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
