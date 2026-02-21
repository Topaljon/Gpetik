import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:helper_open_ai/chat_assistant/translations/phrase_model.dart';
import 'localization_model.dart';
import 'package:http/http.dart' as http;

void main() {
  updateLocalizationFile();
}

Future updateLocalizationFile() async {
  String documentId = "1D9J6VWRIzWZtEJEp1djunaLcazo4BKtvm5TOteACKOY";
  String sheetId = "0";

  String phraseKey = '';
  List<LocalizationModel> localizations = [];
  String localizationFile = """import 'package:get/get.dart';
  
  class Localization extends Translations {
  @override
   Map<String, Map<String, String>> get keys => { """;

  try {
   final url = 'https://docs.google.com/spreadsheets/d/$documentId/export?format=csv&id=$documentId&gid=$sheetId';
   //'https://docs.google.com/spreadsheets/d/1D9J6VWRIzWZtEJEp1djunaLcazo4BKtvm5TOteACKOY/edit?usp=drive_link';

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Downloading Google sheet url "$url" ...');
    stdout.writeln('---------------------------------------');

    var response = await http.get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});

    print('Google sheet csv:\n ${response.body}');

    final bytes = response.bodyBytes.toList();
    final csv = Stream<List<int>>.fromIterable([bytes]);

    final fields = await csv
        .transform(utf8.decoder)
        .transform(const CsvToListConverter(shouldParseNumbers: false,)).toList();

    final index = fields[0]
        .cast<String>()
        .map(_uniformizeKey)
        .takeWhile((x) => x.isNotEmpty)
        .toList();

    for (var r = 1; r < fields.length; r++) {
      final rowValues = fields[r];

      /// Creating a map
      final row = Map<String, String>.fromEntries(
        rowValues
            .asMap()
            .entries
            .where(
              (e) => e.key < index.length,
        )
            .map(
              (e) => MapEntry(index[e.key], e.value),
        ),
      );

      row.forEach((key, value) {
        if (key == 'key') {
          phraseKey = value;
        } else {
          bool languageAdded = false;
          for (var element in localizations) {
            if (element.language == key) {
              element.phrases.add(PhraseModel(key: phraseKey, phrase: value));
              languageAdded = true;
            }
          }
          if (languageAdded == false) {
            localizations.add(LocalizationModel(
                language: key,
                phrases: [PhraseModel(key: phraseKey, phrase: value)]));
          }
        }
      });
    }

    for (var localization in localizations) {
      String language = localization.language;
      String currentLanguageTextCode = "'$language': {\n";
      localizationFile = localizationFile + currentLanguageTextCode;
      for (var phrase in localization.phrases) {
        String phraseKey = phrase.key;
        String phrasePhrase = phrase.phrase.replaceAll(r"'", "\\\'");
        String currentPhraseTextCode = "'$phraseKey': '$phrasePhrase',\n";
        localizationFile = localizationFile + currentPhraseTextCode;
      }
      String currentLanguageCodeEnding = "},\n";
      localizationFile = localizationFile + currentLanguageCodeEnding;
    }
    String fileEnding = """
        };
      }
      """;
    localizationFile = localizationFile + fileEnding;

    stdout.writeln('');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Saving translate_app.g.dart');
    stdout.writeln('---------------------------------------');
    final file = File('translate_app.g.dart');
    await file.writeAsString(localizationFile);
    stdout.writeln('Done...');
  } catch (e) {
    //output error
    stderr.writeln('error: networking error');
    stderr.writeln(e.toString());
  }
}

String _uniformizeKey(String key) {
  key = key.trim().replaceAll('\n', '').toLowerCase();
  return key;
}