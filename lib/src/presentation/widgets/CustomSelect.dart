import 'package:flutter/material.dart';

class CustomSelect<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;
  final T? initialValue;

  const CustomSelect({
    super.key,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CustomSelect<T>> createState() => _CustomSelectState<T>();
}

class _CustomSelectState<T> extends State<CustomSelect<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CustomSelect<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Si la lista de items cambia, actualizamos la selección
    if (oldWidget.items != widget.items) {
      setState(() {
        // Si el valor actual sigue existiendo en la nueva lista, lo mantenemos.
        // Si no, lo limpiamos.
        if (widget.items.contains(selectedValue)) {
          selectedValue = selectedValue;
        } else {
          selectedValue = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // El Dropdown ocupa el espacio disponible
        Expanded(
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              labelText: widget.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
            ),
            value: selectedValue,
            isExpanded:
                true, //  Permite que el dropdown use todo el ancho disponible
            items:
                widget.items
                    .map(
                      (item) => DropdownMenuItem<T>(
                        value: item,
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 250, //  Ajustamos un ancho máximo
                          ),
                          child: Text(
                            widget.itemLabel(item),
                            style: TextStyle(fontSize: 14),
                            softWrap:
                                true, //  Permite el salto de línea automático
                            overflow:
                                TextOverflow.fade, //  Evita cortar el texto
                          ),
                        ),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
              widget.onChanged!(value);
                        },
          ),
        ),
      ],
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     // Etiqueta del campo
    //     Text(
    //       widget.label,
    //       style: TextStyle(
    //         fontSize: 15,
    //         fontWeight: FontWeight.w600,
    //         color: Theme.of(context).colorScheme.onSurface,
    //       ),
    //     ),
    //     const SizedBox(height: 8),

    //     // Dropdown
    //     Container(
    //       padding: const EdgeInsets.symmetric(horizontal: 12),
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).colorScheme.surface,
    //         borderRadius: BorderRadius.circular(10),
    //         border: Border.all(color: Colors.grey.shade400, width: 1),
    //       ),
    //       child: DropdownButtonFormField<T>(
    //         value: widget.initialValue,
    //         items:
    //             widget.items.map((item) {
    //               return DropdownMenuItem<T>(value: item, child: Text(item));
    //             }).toList(),
    //         onChanged: widget.onChanged,
    //         decoration: const InputDecoration(border: InputBorder.none),
    //         isExpanded: true,
    //       ),
    //     ),
    //   ],
    // );
  }
}
