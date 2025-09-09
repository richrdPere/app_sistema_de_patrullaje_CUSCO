import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Modelo de opción del módulo
class ModuloOption {
  final String title;
  final IconData icon;
  final String route;
  final Color backgroundColor;

  ModuloOption({
    required this.title,
    required this.icon,
    required this.route,
    required this.backgroundColor,
  });
}

/// Widget reutilizable para mostrar los módulos en formato Grid
class BuildModuloList extends StatelessWidget {
  final List<ModuloOption> moduloOptions;
  final EdgeInsetsGeometry padding;
  final int? crossAxisCount;

  const BuildModuloList({
    super.key,
    required this.moduloOptions,
    this.padding = const EdgeInsets.all(12),
    this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount ?? (size.width > 600 ? 4 : 3),
        crossAxisSpacing: 12,
        mainAxisSpacing: 15,
        childAspectRatio: 0.9,
      ),
      itemCount: moduloOptions.length,
      itemBuilder: (context, index) {
        final option = moduloOptions[index];

        return GestureDetector(
          onTap: () => context.push(option.route),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: option.backgroundColor,
            child: Padding(
              // padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icono principal
                  Icon(option.icon, size: 35, color: Colors.white),
                  const SizedBox(height: 12),
                  // Título del módulo
                  Text(
                    option.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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

/// BUILD ANTERIOR

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// /// Modelo de opción del módulo
// class ModuloOption {
//   final String title;
//   final String description;
//   final IconData icon;
//   final String route;
//   final Color cardColor;

//   ModuloOption({
//     required this.title,
//     required this.description,
//     required this.icon,
//     required this.route,
//     required this.cardColor,
//   });
// }

/// Widget reutilizable para mostrar los módulos en formato Grid

// class BuildModuloList extends StatelessWidget {
//   final List<ModuloOption> moduloOptions;
//   final EdgeInsetsGeometry padding;
//   final int? crossAxisCount;
//   final double childAspectRatio;

//   const BuildModuloList({
//     super.key,
//     required this.moduloOptions,
//     this.padding = const EdgeInsets.all(12),
//     this.crossAxisCount,
//     this.childAspectRatio = 1.3,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return GridView.builder(
//       padding: padding,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: crossAxisCount ?? (size.width > 600 ? 3 : 2),
//         crossAxisSpacing: 7,
//         mainAxisSpacing: 15,
//         childAspectRatio: childAspectRatio,
//       ),
//       itemCount: moduloOptions.length,
//       itemBuilder: (context, index) {
//         final option = moduloOptions[index];

//         return Card(
//           elevation: 10,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           color: option.cardColor,
//           child: Padding(
//             padding: const EdgeInsets.all(14.0),
//             child: Row(
//               children: [
//                 // Icono principal
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: Icon(option.icon, size: 38, color: Colors.white),
//                 ),
//                 const SizedBox(width: 10),

//                 // Texto y flecha
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           context.push(option.route);
//                         },
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               option.title,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 5),
//                             Text(
//                               option.description,
//                               style: const TextStyle(
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white70,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Flecha de navegación
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: GestureDetector(
//                           onTap: () {
//                             context.go(option.route);
//                           },
//                           child: const Icon(
//                             Icons.arrow_forward_ios,
//                             color: Colors.white,
//                             size: 15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
