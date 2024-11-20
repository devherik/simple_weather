import 'package:flutter/material.dart';
import 'package:simple_weather_app/presentation/controllers/weather_controller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required wcontroll})
      : _weatherController = wcontroll;
  final WeatherController _weatherController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: TextFormField(
                        controller: _searchTextController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelMedium,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            label: Text('Pesquise aqui...')),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FutureBuilder(
                future: widget._weatherController.getWeatherByLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(
                width: 300,
                child: Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: .5,
                )),
          ],
        ),
      ),
    );
  }
}
