import 'package:flutter/material.dart';

class ConfiguracionPage extends StatelessWidget {
  const ConfiguracionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: const Text('Configuración'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Preferencias',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _settingTile(
            icon: Icons.dark_mode,
            title: 'Tema Oscuro',
            subtitle: 'Activado por defecto',
            onTap: () {},
          ),
          _settingTile(
            icon: Icons.language,
            title: 'Idioma',
            subtitle: 'Español',
            onTap: () {},
          ),
          _settingTile(
            icon: Icons.lock,
            title: 'Seguridad',
            subtitle: 'Cambiar contraseña',
            onTap: () {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Sistema',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _settingTile(
            icon: Icons.sync,
            title: 'Sincronización',
            subtitle: 'Última vez: Hoy',
            onTap: () {},
          ),
          _settingTile(
            icon: Icons.info,
            title: 'Acerca de',
            subtitle: 'Versión 1.0.0',
            onTap: () {},
          ),
          _settingTile(
            icon: Icons.logout,
            title: 'Cerrar sesión',
            subtitle: 'Salir de la aplicación',
            onTap: () {},
            danger: true,
          ),
        ],
      ),
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool danger = false,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      tileColor: const Color(0xFF1E1E1E),
      leading: Icon(icon, color: danger ? Colors.redAccent : const Color(0xFFCCFF00)),
      title: Text(
        title,
        style: TextStyle(
          color: danger ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xFFAAAAAA)),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFAAAAAA)),
    );
  }
}
