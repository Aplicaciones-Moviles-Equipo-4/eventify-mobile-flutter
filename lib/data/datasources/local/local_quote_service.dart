import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/quote/quote_model.dart';

class LocalQuoteService {
  static const String _keyPrefix = 'local_quotes_user_';

  Future<void> saveQuote(QuoteModel quote, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$userId';
    
    // Obtenemos las guardadas actualmente
    final List<QuoteModel> existing = await getQuotes(userId);
    
    // Evitamos duplicados por ID
    if (existing.any((q) => q.quoteId == quote.quoteId)) return;
    
    existing.add(quote);
    
    // Guardamos la lista actualizada
    final String encodedData = jsonEncode(existing.map((e) => e.toJson()).toList());
    await prefs.setString(key, encodedData);
  }

  Future<List<QuoteModel>> getQuotes(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$_keyPrefix$userId';
    final String? data = prefs.getString(key);
    
    if (data == null) return [];
    
    try {
      final List<dynamic> decoded = jsonDecode(data);
      return decoded.map((e) => QuoteModel.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> clearQuotes(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_keyPrefix$userId');
  }
}
