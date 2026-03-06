import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ltkcczdfcmtfpeluizft.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0a2NjemRmY210ZnBlbHVpemZ0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUyOTgxMTAsImV4cCI6MjA4MDg3NDExMH0.YuRca19Vv_eSbvyziD_XbMAXJIXXZednh0_z5mMIxA0',
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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color fondo = Color(0xFFB1C1C0);
  static const Color cardColor = Color(0xFFDCEDB9);
  static const Color botonColor = Color(0xFFD2E59E);
  static const Color appBarColor = Color(0xFFCBD081);
  static const Color textoOscuro = Color(0xFF918868);

  Future<List<Map<String, dynamic>>> getProductos() async {
    try {
      final response = await supabase
          .from('Productos')
          .select('id_producto, nombre, precio, descripcion, imagen_url');

      print("Datos recibidos: $response");
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: textoOscuro),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error al conectar con Supabase: ${snapshot.error}"),
            );
          }

          final productos = snapshot.data ?? [];
          if (productos.isEmpty) {
            return const Center(child: Text("No hay productos registrados"));
          }

          return Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.48,
              ),
              itemCount: productos.length,
              itemBuilder: (context, index) {
                // Pasamos el objeto completo 'item' a buildCard
                return buildCard(productos[index]);
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

  // Widget buildCard actualizado para recibir el Map completo
  Widget buildCard(Map<String, dynamic> item) {
    final String titulo = item['nombre'] ?? 'Sin nombre';
    final String descripcion = item['descripcion'] ?? 'Sin descripción';
    final String imagen = item['imagen_url'] ?? 'https://picsum.photos/200';

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
                      height: 200,
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
                        const SizedBox(height: 10),
                        Text(
                          descripcion,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: textoOscuro,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: botonColor,
                              foregroundColor: textoOscuro,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {
                              // NAVEGACIÓN A DETALLE
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetalleProducto(producto: item),
                                ),
                              );
                            },
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

// --- NUEVA PANTALLA DE DETALLE ---
class DetalleProducto extends StatelessWidget {
  final Map<String, dynamic> producto;

  const DetalleProducto({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    const Color fondo = Color(0xFFB1C1C0);
    const Color cardColor = Color(0xFFDCEDB9);
    const Color textoOscuro = Color(0xFF918868);

    return Scaffold(
      backgroundColor: fondo,
      appBar: AppBar(
        title: Text(producto['nombre'] ?? 'Detalle del Producto'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCBD081), Color(0xFFD2E59E)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              producto['imagen_url'] ?? 'https://picsum.photos/600',
              width: double.infinity,
              height: 350,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      producto['nombre'] ?? 'Sin nombre',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textoOscuro,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Precio: \$${producto['precio'] ?? '0'}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const Divider(height: 30, color: textoOscuro),
                    const Text(
                      "Descripción completa:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textoOscuro,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      producto['descripcion'] ?? 'Sin descripción.',
                      style: const TextStyle(fontSize: 16, color: textoOscuro),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
