import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:my_checklist/model/rung.dart';
import 'dart:developer' as dev;

// dart io not supported in web versions

class FilePublish {

  Future<bool> readFile() async {
    dev.log('5 -- FilePublish: In readFile()');
    String data = await rootBundle.loadString('assets/rungFile.txt');
    List<String> lines = const LineSplitter().convert(data);
    dev.log('5 -- FilePublish: lines len: ${lines.length}');
    for (String line in lines) {
      //dev.log('FilePublish inside for loop');
      //dev.log("line: $line");
      List<String> words = line.split('*');
      //dev.log("split");
      // Do something with each word
     //  dev.log("words $words as String");
       dev.log('id: ${words[0]}');
      dev.log('name: ${words[1].trim()}');
      // dev.log('done: ${bool.parse(words[2])}');
       //dev.log('bold: ${bool.parse(words[3])}');
       dev.log('info: ${words[4].trim()}');
       //dev.log('archive: ${bool.parse(words[5])}');
      Rung rung = Rung(rungId: words[0].trim(), name: words[1].trim(), done: bool.parse(words[2].trim()), boldTitle: bool.parse(words[3].trim()), info: words[4].trim(), archive: bool.parse(words[5].trim()));
      Rung.myList.add(rung);

    }
    bool doneFile = Rung.myList.isNotEmpty;
    Future<bool> doneFileFuture = Future.value(doneFile);
    return doneFileFuture;
  }

}