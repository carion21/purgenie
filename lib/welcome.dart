import 'package:flutter/material.dart';
import 'package:purgenie/accueil.dart';
import 'package:purgenie/constant.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(flex: 2),
            Container(
              child: Card(
                child: Image.asset("assets/purgenie.png"),
              ),
            ),
            Spacer(flex: 3),
            Text(
              "Michael Medi",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(
              "jesuiscarion@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .color
                    .withOpacity(0.64),
              ),
            ),
            Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () =>
                      Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Accueil(),
                    ),
                  ),
                  child: Container(
                    height: 60,
                    width: 120,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                        child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Entrer",
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .color
                                    .withOpacity(0.8)),
                          ),
                          SizedBox(width: kDefaultPadding / 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .color
                                .withOpacity(0.8),
                          )
                        ],
                      )),
                    ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
