import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onNotificationsTap;

  // final VoidCallback? onOption1;
  // final VoidCallback? onOption2;
  // final VoidCallback? onOption3;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.onBack,
    this.onNotificationsTap,

    // this.onOption1,
    // this.onOption2,
    // this.onOption3,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      automaticallyImplyLeading: false, // No muestra el back por defecto
      backgroundColor: Colors.white,
      toolbarHeight:
          showBackButton ? kToolbarHeight : 72, // más alto en principal
      // Lado izquierdo: Logo grande en principal, flecha en subpantallas
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
                onPressed: onBack ?? () => context.pop(), // GoRouter back
              )
              : null,
      title:
          showBackButton
              ? Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Image.asset(
                  'assets/img/logo_cusco.png',
                  height: 44, // logo más grande al centro
                  fit: BoxFit.contain,
                ),
              ),

      actions: [
        // Botón de notificaciones
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.black),
          onPressed:
              onNotificationsTap ??
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No hay notificaciones")),
                );
              },
        ),

        // Menú de más opciones
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onSelected: (value) {
            if (value == 'config') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Ir a Configuración')),
              );
            } else if (value == 'logout') {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Cerrar sesión')));
            }
            // if (value == "opcion1" && onOption1 != null) onOption1!();
            // if (value == "opcion2" && onOption2 != null) onOption2!();
            // if (value == "opcion3" && onOption3 != null) onOption3!();
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: 'config',
                  child: Text('Configuración'),
                ),
                const PopupMenuItem(
                  value: 'logout',
                  child: Text('Cerrar sesión'),
                ),
                // const PopupMenuItem(value: "opcion1", child: Text("Perfil")),
                // const PopupMenuItem(
                //   value: "opcion2",
                //   child: Text("Configuraciones"),
                // ),
                // const PopupMenuItem(
                //   value: "opcion3",
                //   child: Text("Cerrar sesión"),
                // ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
