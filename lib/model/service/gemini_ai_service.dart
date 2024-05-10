import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiService {
  static Gemini gemini = Gemini.instance;

  static Future<String> getGeminiResponse(String? ingredient) async {
    try {
      final String question =
          'Tolong berikan alternatif bahan makanan dari $ingredient, tolong berikan jawaban yang tidak bertele-tele dan langsung ke inti jawabannya dan jawab menggunakan bahasa inggris, tolong jangan gunakan ikon *. dan jika $ingredient bukanlah sebuah bahan makanan, maka jawab "maaf $ingredient bukanlah bahan makanan" dalam bahasa inggris ';
      Completer<String> completer = Completer<String>();
      gemini.streamGenerateContent(question).listen((event) {
        String response = event.content?.parts?.fold('',
                (previousValue, element) => '$previousValue${element.text}') ??
            '';
        completer.complete(response);
      });
      return completer.future;
    } on DioException catch (e) {
      throw e.toString();
    }
  }
}
