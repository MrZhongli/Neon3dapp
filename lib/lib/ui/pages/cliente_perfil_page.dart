import 'package:flutter/material.dart';

class ClientePerfilPage extends StatelessWidget {
  final Map<String, dynamic> cliente;

  const ClientePerfilPage({super.key, required this.cliente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(cliente['nombre']),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo('Correo:', cliente['correo']),
            _buildInfo('Teléfono:', cliente['telefono']),
            _buildInfo('Dirección:', cliente['direccion']),
            const SizedBox(height: 20),
            const Text(
              'Presupuestos/Impresiones',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cliente['presupuestos'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      cliente['presupuestos'][index],
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(Icons.print, color: Color(0xFFCCFF00)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$label $value',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
