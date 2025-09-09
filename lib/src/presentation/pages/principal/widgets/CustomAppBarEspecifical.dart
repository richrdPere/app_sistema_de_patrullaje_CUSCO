import 'package:flutter/material.dart';

class CustomAppBarEspecifical extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onOption1;
  final VoidCallback? onOption2;
  final VoidCallback? onOption3;

  const CustomAppBarEspecifical({
    super.key,
    required this.title,
    this.onNotificationsTap,
    this.onOption1,
    this.onOption2,
    this.onOption3,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // Logo
          Image.asset(
            "assets/img/logo_cusco.png", // Cambia la ruta de tu logo
            height: 45,
          ),
          const SizedBox(width: 10),
          // Texto principal
          // Text(
          //   title,
          //   style: const TextStyle(
          //     color: Colors.black,
          //     fontWeight: FontWeight.bold,
          //     fontSize: 18,
          //   ),
          // ),
        ],
      ),
      actions: [
        // Botón de notificaciones
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed: onNotificationsTap ?? () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No hay notificaciones")),
            );
          },
        ),

        // Menú de más opciones
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) {
            if (value == "opcion1" && onOption1 != null) onOption1!();
            if (value == "opcion2" && onOption2 != null) onOption2!();
            if (value == "opcion3" && onOption3 != null) onOption3!();
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: "opcion1", child: Text("Perfil")),
            const PopupMenuItem(value: "opcion2", child: Text("Configuraciones")),
            const PopupMenuItem(value: "opcion3", child: Text("Cerrar sesión")),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
