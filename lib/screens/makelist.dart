import 'package:flutter/material.dart';

class MakeList extends StatelessWidget {
  MakeList({super.key});

  // 1. [80, 120, 190], pointer value: 100
  // 2. [50, 110, 210], pointer value: 280
  // 3. [20, 40, 60], pointer value: 10

  List<Map<String, List<int>>> rangeDataList = [
    {
      "rangevalue": [80, 120, 190],
      "pointervalaue": [100],
    },
    {
      "rangevalue": [50, 110, 210],
      "pointervalaue": [280],
    },
    {
      "rangevalue": [20, 40, 60],
      "pointervalaue": [10],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rangeDataList.length,
      itemBuilder: (BuildContext context, int index) {
        return MyListItemRowClass(itemObject: rangeDataList[index]);
      },
    );
  }
}

class MyListItemRowClass extends StatefulWidget {
  final Map<String, List<int>> itemObject;

  const MyListItemRowClass({super.key, required this.itemObject});

  @override
  _MyListItemRowClassState createState() => _MyListItemRowClassState();
}

class _MyListItemRowClassState extends State<MyListItemRowClass> {
  var arrayOfcolor = [Colors.blue, Colors.green, Colors.yellow, Colors.red];
  var weightlist = ["Underweight", "Normal", "Overweight", "Obesity"];

  Object? pointerValuePresnt;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: makeWidgetChildren(widget.itemObject)),
    );
  }

  List<Widget> makeWidgetChildren(itemObject) {
    //row here
    List<Widget> children = [];
    List<int> data = itemObject['rangevalue'];
    List<int> pVList = itemObject['pointervalaue'];
    int pV = pVList[0];
    print(pV);

    data.insert(data.length, data[data.length - 1] + 100);

    var pointerValuePresnt = false;

    for (var i = 0; i < data.length; i++) {
      String mytext = data[i].toString();
      int minvalue = 0;

      bool showPv = false;

      if (i == 0) {
        mytext = "";
        minvalue = 0;
      } else {
        mytext = data[i - 1].toString();
        minvalue = data[i - 1];
      }

      if (pointerValuePresnt == true) {
        showPv = false;
      } else {
        if (pV < data[i]) {
          pointerValuePresnt = true;
          showPv = true;
          print(pointerValuePresnt);
        }
      }

      children.add(
        Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mytext,
                  style: const TextStyle(fontSize: 13),
                  // textAlign: TextAlign.right,
                ),
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width / 4,
                  color: arrayOfcolor[i],
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        thumbColor: Colors.transparent,
                        thumbShape: showPv
                            ? const RoundSliderThumbShape(
                                enabledThumbRadius: 10.0)
                            : const RoundSliderThumbShape(
                                enabledThumbRadius: 0.0),
                        overlayShape: SliderComponentShape.noThumb),
                    child: Slider(
                      activeColor: arrayOfcolor[i],
                      inactiveColor: arrayOfcolor[i],
                      onChanged: (value) {},
                      min: minvalue.toDouble(),
                      max: data[i].toDouble(),
                      value: showPv ? pV.toDouble() : data[i].toDouble(),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    weightlist[i].toString(),
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            )),
      );
      print(data[i].toString());
    }
    return children;
  }
}
