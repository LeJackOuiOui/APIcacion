import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // READ: Obtener todas las notas
  Future<List<Map<String, dynamic>>> getNotas() async {
    final response = await _client
        .from('notas')
        .select()
        .order('created_at', ascending: false);
    return response;
  }

  // CREATE: Insertar una nota
  Future<void> insertNota(String titulo) async {
    await _client.from('notas').insert({'titulo': titulo});
  }

  // DELETE: Borrar por ID
  Future<void> deleteNota(int id) async {
    await _client.from('notas').delete().match({'id': id});
  }
}
