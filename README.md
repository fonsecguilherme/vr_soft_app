## Documentação do Projeto 🇧🇷

## Visão Geral

Este desafio foi proposto pela equipe da VR Software, e se trata de um CRUD de um sistema academico. É possível consultar, criar, excluir e editar tanto alunos quanto cursos. Além disso há uma parte que é possível matricular um aluno a um curso e também remover esse vínculo.

### Página Inicial

- **Página Inicial**: Tela principal onde é possível escolher uma ação a ser realizada.
  - **Alunos**: Na página de alunos há uma listagem dos alunos matriculados assim que a tela é iniciada. Além disso, também é mostrado em baixo as as ações de excluir, cadastrar e editar aluno.
  - **Cursos**: Na página de cursos há uma listagem dos cursos registrados assim que a tela é iniciada. Além disso, também é mostrado em baixo as as ações de excluir, cadastrar e editar um curso.
  - **Matrícula**: Na página de matrícula há  dois campos de texto com um toggle button onde é possível selecionar a ação de víncular ou apagar aluno de um curso. Com uma SnackBar indicando se a ação foi realizada com sucesso ou não.

# Visão Técnica do Projeto

## Tecnologias e Pacotes
 -  **Flutter - v3.24.0**
 -  **PostgreSQL 17**
 -  **Java 23**
 -  **Spring v3.3.4**


### Pacotes Dart e Flutter

- **[Bloc](https://pub.dev/packages/bloc)**: Uma biblioteca para implementar o padrão BLoC.
- **[Bloc_test](https://pub.dev/packages/bloc_test)**: Pacote usado para testar eventos e estados BLoC.
- **[Equatable](https://pub.dev/packages/equatable)**: Pacote usado para comparação entre objetos.
- **[Flutter_bloc](https://pub.dev/packages/flutter_bloc)**: Fornece integração entre Flutter e BLoC para gerenciamento de estado.
- **[HTTP](https://pub.dev/packages/http)**: Pacote utilizado para criar requisições web.
- **[Mocktail](https://pub.dev/packages/mocktail)**: Um pacote usado para criar mocks para testes unitários.

### Principais Recursos e Práticas

- **Gerenciamento de Estado**: Foi utilizado BLoC e Flutter BLoC para gerenciar o estado do aplicativo.
- **Injeção de Dependência**: Gerenciado através do  próprio Provider que já vem incluso com o pacote Flutter BLoC.
- **Solicitações de API**: HTTP para comunicação de rede.
- **Testes**: Mocktail, Bloc Test para testes unitários e de widgets.

Esta combinação de pacotes e práticas garante uma arquitetura de aplicativo robusta, manutenível e testável.

## BLoC

- Neste projeto, escolhi usar **cubits** para gerenciamento de estado. Minha escolha foi motivada por vários motivos: cubits/BLoC é um padrão bem definido, altamente testável, amplamente adotado no mercado e oferece flexibilidade para ajustar a interface do usuário.

## Testes

- Testes de widget da home_page e students_page e save_student_widget, além do testes do students_cubit.

## Estrutura do Aplicativo
- **Data**: Lidar com a comunicação com fontes externas e gerenciamento de dados.
- **Domain**: Lida com as abstrações criada que devem mostrar como a camada de Data deve implementar os métodos criados. 
- **Presentation**: Representação visual das telas do aplicativo, junto com os states e cubits.
- **Utils**: Classes que ajudam/encapsulam alguma lógica para ajudar a implementaçào de algo no app.

## Estrutura da API
- **Controllers**: Recebem os dados vindos do app e se comunica com o a API.
- **DTOs**: Representação de um objeto de transferência de dados. 
- **Models**: Representação de entidades no banco de dados.
- **Repositories**: Repositories Spring Data JPA para uma entendidade.

<p float="left">
  <img src="https://github.com/user-attachments/assets/4e18077d-d439-4dfb-a4b5-bf2b1aaf6b94" width="350" />
  <img src="https://github.com/user-attachments/assets/b4691d47-33e1-4a20-bbef-2a3e3ef1fd2a" width="350" />
</p>

## Vídeo
[Video](https://drive.google.com/file/d/1VjNy7GOyttpxqOHQUH4smLgJ3Hqmz7AS/view?usp=sharing)

## Screenshots
* Home page
<p float="left">
  <img src="https://github.com/user-attachments/assets/71d74b3d-d456-4cbe-8baf-322003220cc4" width="350" />
</p>

* Student page 
<p float="left">
<img src="https://github.com/user-attachments/assets/49170d90-c0ff-4d9b-831e-0b98591d67a0" width="350" />
</p>

* Courses Page 
<p float="left">
  <img src="https://github.com/user-attachments/assets/fefba4e1-b53a-45f6-8096-4a227eb7ed22" width="350" />
</p>

* Enroll Page 
<p float="left">
  <img src="https://github.com/user-attachments/assets/3c97ca4f-09a8-406a-8b0d-cd90bdafef1a" width="350" />
</p>
