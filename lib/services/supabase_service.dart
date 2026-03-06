import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final _supabase = Supabase.instance.client;

  // SELECT: Obtener todos los productos
  Future<List<Map<String, dynamic>>> getProductos() async {
    try {
      final response = await _supabase
          .from('Productos')
          .select()
          .order('id_producto', ascending: true);
      return response;
    } catch (e) {
      throw Exception('Error al obtener productos: $e');
    }
  }
}
