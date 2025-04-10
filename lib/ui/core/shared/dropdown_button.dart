import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/core/themes/app_colors.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final List<Map<String, String>> languages = [
    {'name': 'Português', 'countryCode': 'pt-br'},
    {'name': 'Árabe', 'countryCode': 'ar'},
    {'name': 'Chinês', 'countryCode': 'zh-cn'},
    {'name': 'Coreano', 'countryCode': 'ko'},
    {'name': 'Espanhol', 'countryCode': 'es'},
    {'name': 'Francês', 'countryCode': 'fr'},
    {'name': 'Hindi', 'countryCode': 'hi'},
    {'name': 'Inglês', 'countryCode': 'en'},
    {'name': 'Italiano', 'countryCode': 'it'},
    {'name': 'Japonês', 'countryCode': 'ja'},
    {'name': 'Russo', 'countryCode': 'ru'},
    {'name': 'Turco', 'countryCode': 'tr'},
  ];

  String selectedLanguage = 'Linguagem'; // Texto inicial do botão

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
              Text(
                selectedLanguage, // Exibe a linguagem selecionada
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
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
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CountryFlag.fromLanguageCode(
                            languages[index]['countryCode']!,
                            width: 30,
                            height: 20,
                          ),
                          title: Text(languages[index]['name']!),
                          onTap: () {
                            setState(() {
                              selectedLanguage = languages[index]['name']!;
                            });
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
}
