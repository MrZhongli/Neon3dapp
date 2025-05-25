import 'package:calculator3d_app/lib/ui/pages/cliente_form_page.dart';
import 'package:calculator3d_app/lib/ui/pages/cliente_perfil_page.dart';
import 'package:flutter/material.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({super.key});

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage> {
  final List<Map<String, dynamic>> clientes = [
    {
      'nombre': 'Juan Pérez',
      'correo': 'juan@example.com',
      'telefono': '04141234567',
      'direccion': 'Av. Libertador',
      'presupuestos': ['Vandal tamaño real', 'Arlecchino pin']
    },
    {
      'nombre': 'María García',
      'correo': 'maria@example.com',
      'telefono': '04149876543',
      'direccion': 'Calle Sucre',
      'presupuestos': ['Charmander figura', 'Base personalizada']
    },
  ];

  void _navigateToForm() async {
    final nuevoCliente = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const ClienteFormPage()),
    );

    if (nuevoCliente != null) {
      setState(() {
        nuevoCliente['presupuestos'] = [];
        clientes.add(nuevoCliente);
      });
    }
  }

  void _navigateToPerfil(Map<String, dynamic> cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ClientePerfilPage(cliente: cliente),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Clientes'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            onPressed: _navigateToForm,
            tooltip: 'Agregar cliente',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: clientes.length,
          itemBuilder: (context, index) {
            final cliente = clientes[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFCCFF00)),
                title: Text(
                  cliente['nombre'],
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  cliente['correo'],
                  style: const TextStyle(color: Color(0xFFAAAAAA)),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFFAAAAAA), size: 16),
                  onPressed: () => _navigateToPerfil(cliente),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        backgroundColor: const Color(0xFFCCFF00),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: 'Nuevo cliente',
      ),
    );
  }
}

// ClienteFormPage igual al anterior que ya tienes
