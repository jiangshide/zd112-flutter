import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(new LiveMain());

class LiveMain extends StatelessWidget{
  @override
   build(BuildContext context) => new MaterialApp(home: new RandomWords(),theme: new ThemeData(
     primaryColor: Colors.lightBlue,
   ),);
    // Widget build(BuildContext context) {
    //   // TODO: implement build
    //   return new MaterialApp(
    //     title: 'main',
    //     home: new RandomWords(),
    //   );
    // }
}

class RandomWords extends StatefulWidget{
  @override
    createState() => new RandomWordsState();
    // State<StatefulWidget> createState() {
    //   // TODO: implement createState
    //   return new RandomWordsState();
    // }

}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = new TextStyle(fontSize: 18.0);
  
  @override
  build(BuildContext context) => new Scaffold(
    appBar: new AppBar(
      title: new Text('The Words'),
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.list),onPressed: _pushSaved)
      ],
      ),
    body: _buildSuggestions(),
    );
    // Widget build(BuildContext context) {
    //   // TODO: implement build
    //   return new Scaffold(
    //     appBar: new AppBar(
    //       title: new Text('The Words'),
    //     ),
    //     body: _buildSuggestions(),
    //   );
    // }

    Widget _buildSuggestions(){
      return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context,i){
          if(i.isOdd)return new Divider();
          final index=i ~/2;
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        },
      );
    }

    Widget _buildRow(WordPair pair){
      final alreadySaved = _saved.contains(pair);
      return new ListTile(
        title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ),
        trailing: new Icon(
          alreadySaved?Icons.favorite:Icons.favorite_border,
          color: alreadySaved?Colors.red:null,
        ),
        onTap: (){
          setState((){
            if(alreadySaved){
              _saved.remove(pair);
            }else{
              _saved.add(pair);
            }
          });
        },
      );
    }

    void _pushSaved(){
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            final titles = _saved.map(
              (pair){
                return new ListTile(
                  title: new Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              }
            );
            final divided = ListTile.divideTiles(
              context: context,
              tiles: titles,
            ).toList();
            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestions'),
              ),
              body: new ListView(children:divided),
            );
          }
        )
      );
    }
}