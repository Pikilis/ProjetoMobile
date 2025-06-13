import 'database.dart';
import '../models/configuracao_model.dart';

class ConfiguracaoRepository {
  Future<void> salvarConfiguracao(ConfiguracaoModel config) async {
    final db = await AppDatabase.instance;
    await db.delete('configuracao'); // Sempre 1 config única
    await db.insert('configuracao', config.toJson());
  }

  Future<ConfiguracaoModel?> getConfiguracao() async {
    final db = await AppDatabase.instance;
    final result = await db.query('configuracao');
    if (result.isNotEmpty) {
      return ConfiguracaoModel.fromJson(result.first);
    }
    return null;
  }
}
