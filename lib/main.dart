import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'TU_SUPABASE_URL',
    anonKey: 'TU_SUPABASE_ANON_KEY',
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APIcacion',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // Cambiado a StatefulWidget para manejar estados si es necesario
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PALETA DE COLORES
  static const Color fondo = Color(0xFFB1C1C0);
  static const Color cardColor = Color(0xFFDCEDB9);
  static const Color botonColor = Color(0xFFD2E59E);
  static const Color appBarColor = Color(0xFFCBD081);
  static const Color textoOscuro = Color(0xFF918868);

  // FUNCIÓN CRUD: SELECT
  // Esta función va a Supabase y trae la lista de productos
  Future<List<Map<String, dynamic>>> getProductos() async {
    try {
      final response = await supabase
          .from('Productos')
          .select(
            'id_producto, nombre, precio, descripcion, imagen_url, created_at',
          );
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print("Error en Supabase: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCBD081), Color(0xFFD2E59E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: const Color(0xFF6B4F2A),
            child: Image.asset('assets/logo.png', fit: BoxFit.contain),
          ),
        ),
        leadingWidth: 60,
        title: const Text('APIcacion', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      // IMPLEMENTACIÓN DEL FUTUREBUILDER
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getProductos(),
        builder: (context, snapshot) {
          // 1. Mientras carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: textoOscuro),
            );
          }

          // 2. Si hay error
          if (snapshot.hasError) {
            return Center(
              child: Text("Error al conectar con Supabase: ${snapshot.error}"),
            );
          }

          // 3. Si no hay datos
          final productos = snapshot.data ?? [];
          if (productos.isEmpty) {
            return const Center(child: Text("No hay productos registrados"));
          }

          // 4. Mostrar Grid con datos reales
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Ajustado para que quepa el contenido
              ),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final item = productos[index];
                return buildCard(
                  item['nombre'] ?? 'Sin nombre',
                  item['descripcion'] ?? 'Sin descripción',
                  item['imagen_url'] ?? 'https://picsum.photos/200',
                );
              },
            ),
          );
        },
      ),

      bottomNavigationBar: BottomAppBar(
        color: appBarColor,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("© 2026 APIcacion", style: TextStyle(color: Colors.white)),
              Text(
                "Todos los derechos reservados",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String titulo, String descripcion, String imagen) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool hovering = false;
        return MouseRegion(
          onEnter: (_) => setState(() => hovering = true),
          onExit: (_) => setState(() => hovering = false),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: hovering ? 1.05 : 1.0,
            child: Card(
              color: cardColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      imagen,
                      height: 100, // Un poco más pequeña para el grid
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: textoOscuro,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: textoOscuro,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: botonColor,
                              foregroundColor: textoOscuro,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Ver más",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
