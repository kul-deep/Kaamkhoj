import 'package:flutter/material.dart';



class RateCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Material(
            child: ListView.builder(
      itemBuilder: (context, i) {
        if (i >= data.length) return null;
        return ExpansionTile(
            title: Text('name: ${data[i].title}'),
            children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0,3.0,20.0,3.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '${data[i].children[0].title}',
                        style: TextStyle(fontSize: 18.0, color: Colors.grey))
                  ])),
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: '${data[i].children[1].title}',
                      style: TextStyle(fontSize: 18.0, color: Colors.redAccent))
                ])),

              ],
            ),
          ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,3.0,20.0,3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${data[i].children[0].title}',
                                style: TextStyle(fontSize: 18.0, color: Colors.grey))
                          ])),
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${data[i].children[1].title}',
                              style: TextStyle(fontSize: 18.0, color: Colors.redAccent))
                        ])),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0,3.0,20.0,3.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${data[i].children[0].title}',
                                style: TextStyle(fontSize: 18.0, color: Colors.grey))
                          ])),
                    ),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${data[i].children[1].title}',
                              style: TextStyle(fontSize: 18.0, color: Colors.redAccent))
                        ])),

                  ],
                ),
              ),


//              RichText(
//                text: TextSpan(
//                  children: <TextSpan>[
//                    TextSpan(text: 'hello', style: TextStyle(color: Colors.red)),
//                    TextSpan(text: ' world', style: TextStyle(color: Colors.blue)),
//                  ],
//                ),
//              ),
////              Text('firstname: ${data[i].children[0].title}'),
//              Text('firstname: ${data[i].children[1].title}'),
//        ]
        ]);
      },
      itemCount: data.length,
    )));
  }
}


class Entry {
  const Entry(this.title, [this.children = const <Entry>[]]);
  final String title;
  final List<Entry> children;
}

class ExpansionTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expansion List'),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) => EntryItem(
            data[index],
          ),
        ),
      ),
    );
  }
}

// This is the entire multi-level list displayed by this app
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  // Second Row
  Entry('Chapter B', <Entry>[
    Entry('Section B0'),
    Entry('Section B1'),
  ]),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      )
    ],
  ),
];

// Create the Widget for the row
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  // This function recursively creates the multi-level list rows.
  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
