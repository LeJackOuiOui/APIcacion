import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 6, 161, 125)),
      ),
      home: const MyHomePage(title: 'Cultivos en Colombia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 3, // 3 cards por fila
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
          children: [

            buildCard(
              "Maíz",
              "Cultivo de maíz",
              "https://picsum.photos/200",
            ),

            buildCard(
              "Papa",
              "Cultivo de papa",
              "https://picsum.photos/201",
            ),

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

            buildCard(
              "Arroz",
              "Cultivo de arroz",
              "https://picsum.photos/204",
            ),

            buildCard(
              "Frijol",
              "Cultivo de frijol",
              "https://picsum.photos/205",
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String titulo, String descripcion, String imagen) {
    return Card(
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

                Text(
                  descripcion,
                  style: const TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 8),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Ver más"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: 'TU_SUPABASE_URL',
//     anonKey: 'TU_SUPABASE_ANON_KEY',
//   );

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Supabase CRUD',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
//       home: const NotasPage(), // Aquí indicamos la pantalla de inicio
//     );
//   }
// }

// // 2. La pantalla que muestra la lista de la "API"
// class NotasPage extends StatefulWidget {
//   const NotasPage({super.key});

//   @override
//   State<NotasPage> createState() => _NotasPageState();
// }

// class _NotasPageState extends State<NotasPage> {
//   // Llamamos al cliente directamente para este ejemplo rápido
//   final _notasStream = Supabase.instance.client
//       .from('notas')
//       .stream(primaryKey: ['id']);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Mis Notas en Supabase')),
//       body: StreamBuilder<List<Map<String, dynamic>>>(
//         stream: _notasStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData)
//             return const Center(child: CircularProgressIndicator());

//           final notas = snapshot.data!;

//           return ListView.builder(
//             itemCount: notas.length,
//             itemBuilder: (context, index) {
// return Card(
//   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//   elevation: 4,
//   shape: RoundedRectangleBorder(
//     borderRadius: BorderRadius.circular(12),
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [

//       // Imagen
//       ClipRRect(
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//         child: Image.network(
//           "https://picsum.photos/400/200?random=$index",
//           height: 180,
//           width: double.infinity,
//           fit: BoxFit.cover,
//         ),
//       ),

//       Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // Titulo
//             Text(
//               notas[index]['titulo'] ?? 'Sin título',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 6),

//             // Descripción
//             const Text(
//               "Pequeña descripción de la nota.",
//             ),

//             const SizedBox(height: 10),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [

//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text("Ver más"),
//                 ),

//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () async {
//                     await Supabase.instance.client
//                         .from('notas')
//                         .delete()
//                         .match({'id': notas[index]['id']});
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       )
//     ],
//   ),
// );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () async {
//           // Ejemplo de INSERT (POST)
//           await Supabase.instance.client.from('notas').insert({
//             'titulo': 'Nueva nota ${DateTime.now()}',
//           });
//         },
//       ),
//     );
//   }
// }

// // Acceso rápido al cliente
// final supabase = Supabase.instance.client;
