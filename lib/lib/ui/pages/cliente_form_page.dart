import 'package:flutter/material.dart';

class ClientesPage extends StatelessWidget {
  const ClientesPage({super.key});

  void _navigateToForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ClienteFormPage()),
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
            onPressed: () => _navigateToForm(context),
            tooltip: 'Agregar cliente',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFCCFF00)),
                title: const Text(
                  'Nombre del Cliente',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  'correo@ejemplo.com',
                  style: TextStyle(color: Color(0xFFAAAAAA)),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xFFAAAAAA), size: 16),
                  onPressed: () {},
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context),
        backgroundColor: const Color(0xFFCCFF00),
        foregroundColor: Colors.black,
        child: const Icon(Icons.add),
        tooltip: 'Nuevo cliente',
      ),
    );
  }
}

class ClienteFormPage extends StatelessWidget {
  const ClienteFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Nuevo Cliente'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildTextField(nameController, 'Nombre completo'),
            _buildTextField(emailController, 'Correo electrónico'),
            _buildTextField(phoneController, 'Teléfono'),
            _buildTextField(addressController, 'Dirección'),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFCCFF00),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                // Aquí guardarías el cliente
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFFAAAAAA)),
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
