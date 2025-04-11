import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class Dropdown<T> extends StatefulWidget {
  final List<T> data;
  final Widget Function(T)? leading;
  final Widget Function(T) render;
  final void Function(T)? onSelect;
  final Widget? placeholder;
  final T? value;

  const Dropdown({
    super.key,
    this.leading,
    required this.render,
    required this.data,
    this.onSelect,
    this.value,
    this.placeholder,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  T? value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showLanguageModal(context);
      },
      child: SizedBox(
        height: 42,
        width: 158, // Define a largura do botão
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              value != null
                  ? widget.render(value as T)
                  : widget.placeholder ?? Text("Selecione"),
              Icon(Icons.arrow_drop_down, color: AppColors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Permite que o modal ocupe mais espaço
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false, // Permite que o modal seja arrastado
          initialChildSize: 0.8, // Define o tamanho inicial (80% da tela)
          minChildSize: 0.5, // Tamanho mínimo (50% da tela)
          maxChildSize: 0.9, // Tamanho máximo (90% da tela)
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Linguagens',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      controller: scrollController, // Conecta o scroll ao modal
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        T currentValue = widget.data[index];

                        return ListTile(
                          leading:
                              widget.leading != null
                                  ? widget.leading!(currentValue)
                                  : null,
                          title: widget.render(currentValue),
                          onTap: () {
                            if (widget.onSelect != null) {
                              widget.onSelect!(currentValue);
                            }

                            if (widget.value == null) {
                              setState(() {
                                value = currentValue;
                              });
                            }
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }
}
