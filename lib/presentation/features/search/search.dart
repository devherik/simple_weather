import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
          controller: _searchTextController,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              label: Text('Pesquise aqui...',
                  style: Theme.of(context).textTheme.labelLarge)),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Builder(
                  builder: (context) => IconButton(
                      icon: Icon(
                        Iconsax.close_circle,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: () => {})),
              Builder(
                  builder: (context) => IconButton(
                      icon: Icon(
                        Iconsax.save_2,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: () {})),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
                future: widget._weatherController
                    .getForecastByCity(_searchTextController.text.trim()),
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
