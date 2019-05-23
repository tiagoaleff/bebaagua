Protótipo Aplicativo Lembrete de beber água

O que falta:
1 - Falta funcionalidade para programar as notificações pelo tempo de distribuição
    obs: ver documentação: https://github.com/MaikuB/flutter_local_notifications
2 - Persistência das informações do histórico de água.
3 - Persistência da quantidade bebida durante o dia.

Materiais de apoio:

1 - Catalogo de componentes:
    https://flutter.dev/docs/development/ui/widgets

2 - Para adicionar imagens ou instalar dependecias utilize o arquivo pubspec.yaml na raiz da aplicação. Nele é possível informar qual o diretório que as imagens (assets) estarão na sua aplicação
    https://dart.dev/tools/pub/pubspec

3 - Para incontrar versões de pacotes para instalar na aplicação utilize a plataforma https://pub.dev/, lembre-se de adicionar no arquivo pubspec.yaml na raíz da aplicação. Nela possui exemplos de como usar um determinado pacote e versão de instalação

4 - Diversos conteúdos: https://medium.com/flutter

5 - Básico sobre dart: https://dart.dev/guides/language/language-tour

6 - Informações sobre o Coletor de Lixo do Flutter https://medium.com/flutter/flutter-dont-fear-the-garbage-collector-d69b3ff1ca30

7 - Apps com componentes responsivos: https://github.com/flutter/flutter/wiki/Creating-Responsive-Appsgit remote add origin

Bug: Não foi ajustado o retorno para a tela Home, o aplicativo começa a 'carregar infinitamente'.

Resumo App:

Arquivo main.dart
    Possui o metodo principal da nossa aplicação: configura tema principal da nossa aplicação. Identifica se possui um arquivo gravado com as informações de média de hidratação diária.

Arquivo ui/home.dart
    Possui o botão de beber água e atualizar progresso do usuário.

Arquivo ui/historico.dart
    Possui uma lista estática de um possível histórico de água bebida. Com possíbilidade de remoção da lista ao deslizar para o lado (a lista é estática, então ao voltar para essa tela ela irá retornar)

Arquivo ui/configuracao.dart
    Possui os campos de entrada de peso e idade para o cálculo de quantidade de agua necessária por pessoa.

Arquivo repositorio/Repositorio.dart
    Possui a lógica para salvar a imformação da média de água diária por pessoa. Esse arquivo pode ser alterado para mudar a forma de persistência, utilizando persistênica com o Shared Preferences Plugin (https://pub.dev/packages/shared_preferences),
Sqflite (https://pub.dev/packages/sqflite) ou o Firebase Cloude Storage (https://pub.dev/packages/firebase_storage)







