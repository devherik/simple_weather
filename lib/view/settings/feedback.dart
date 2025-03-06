import 'package:flutter/material.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class FeedbackPage extends StatelessWidget {
  FeedbackPage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          global.mediumBoxSpace,
          Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Deixe seu feedback',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  global.verySmallBoxSpace,
                  Text(
                    'Toda sugestão é bem-vinda e será \nextremamente útil para o desenvolvimento do aplicativo.',
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
          global.smallBoxSpace,
          Flexible(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: TextFormField(
                  controller: controller,
                  maxLines: 10,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                      hintText: 'Digite aqui',
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 0,
                              color: Theme.of(context).colorScheme.secondary)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                              width: 1.0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary))),
                ),
              ),
            ),
          ),
          global.smallBoxSpace,
          Flexible(
            flex: 2,
            fit: FlexFit.loose,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  onPressed: () => context.pop(),
                  splashColor: global.red,
                  elevation: 0,
                  color: Theme.of(context).colorScheme.primary,
                  minWidth: MediaQuery.of(context).size.width * .3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.close_circle,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  onPressed: () async {},
                  splashColor: Theme.of(context).colorScheme.primary,
                  elevation: 1,
                  color: global.blue,
                  minWidth: MediaQuery.of(context).size.width * .6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.send_2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        ' Enviar',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            letterSpacing: 3,
                            fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
