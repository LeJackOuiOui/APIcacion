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

  // COLORES DE TU PALETA (ajustados para mejor contraste)
  static const Color fondo = Color(0xFFB1C1C0);
  static const Color cardColor = Color(0xFFDCEDB9);
  static const Color botonColor = Color(0xFFD2E59E);
  static const Color textoOscuro = Color(0xFF5E5A46);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondo,

      appBar: AppBar(
        elevation: 0,

        // GRADIENTE COOL
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFCBD081),
                Color(0xFFD2E59E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            fit: BoxFit.contain,
          ),
        ),

        leadingWidth: 60,

        title: const Text(
          'APIcacion',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
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
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          children: [
            buildCard("Maíz", "Cultivo de maíz", "https://picsum.photos/200"),
            buildCard("Papa", "Cultivo de papa", "https://picsum.photos/201"),
            buildCard("Tomate", "Cultivo de tomate", "https://picsum.photos/202"),
            buildCard("Café", "Producción de café", "https://picsum.photos/203"),
            buildCard("Arroz", "Cultivo de arroz", "https://picsum.photos/204"),
            buildCard("Frijol", "Cultivo de frijol", "https://picsum.photos/205"),
          ],
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFCBD081),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "© 2026 APIcacion",
                style: TextStyle(color: Colors.white),
              ),
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
    return Card(
      color: cardColor,
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
                    color: textoOscuro,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  descripcion,
                  style: const TextStyle(
                    fontSize: 12,
                    color: textoOscuro,
                  ),
                ),

                const SizedBox(height: 8),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: botonColor,
                    foregroundColor: textoOscuro,
                  ),
                  onPressed: () {},
                  child: const Text("Ver más"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}