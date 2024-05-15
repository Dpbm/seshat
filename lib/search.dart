import 'package:flutter/material.dart';
import 'package:seshat/utils/icons.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    const double topBarSize = 120;
    final double bodySize = height - topBarSize;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0,
            )),
        body: SizedBox(
            width: width,
            height: height,
            child: Column(children: [
              Container(
                  //height: topBarSize,
                  color: Theme.of(context).colorScheme.primary,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(26, 10, 26, 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width,
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: IconButton(
                                  onPressed: () => {Navigator.pop(context)},
                                  icon: back(),
                                )),
                          ),
                          Container(
                              width: width,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius:
                                      const BorderRadiusDirectional.all(
                                          Radius.circular(10))),
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {}, icon: searchPrefix()),
                                    TextField(
                                      keyboardType: TextInputType.text,
                                      autofocus: true,
                                      onChanged: (value) => {},
                                      textAlign: TextAlign.left,
                                      showCursor: true,
                                    )
                                  ])),
                        ]),
                  ))
            ])));
  }
}
