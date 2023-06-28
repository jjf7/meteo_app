import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class HumanFormats {
  static Future<String> date(DateTime date) async {
    await initializeDateFormatting('es_ES', null);
    var formatter = DateFormat("d 'de' MMMM 'del' y", 'es_ES');
    return formatter.format(date);
  }
}
