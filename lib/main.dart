import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APIcacion'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Función de búsqueda en desarrollo"),
                ),
              );
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 3, // 3 cards por fila
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          children: [
            buildCard("Maíz", "Cultivo de maíz", "https://picsum.photos/200"),

            buildCard("Papa", "Cultivo de papa", "https://picsum.photos/201"),

            buildCard(
              "Tomate",
              "Cultivo de tomate",
              "https://picsum.photos/202",
            ),

            buildCard(
              "Café",
              "Producción de café",
              "https://picsum.photos/203",
            ),

            buildCard("Arroz", "Cultivo de arroz", "https://picsum.photos/204"),

            buildCard(
              "Frijol",
              "Cultivo de frijol",
              "https://picsum.photos/205",
            ),
          ],
        ),
      ),
      // PIE DE PÁGINA PROFESIONAL SIN ESTILOS
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("© 2026 APIcacion"),
              Text("Todos los derechos reservados"),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String titulo, String descripcion, String imagen) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imagen,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(descripcion, style: const TextStyle(fontSize: 12)),

                const SizedBox(height: 8),

                ElevatedButton(onPressed: () {}, child: const Text("Ver más")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
