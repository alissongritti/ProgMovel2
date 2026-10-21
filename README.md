# Cadastro de Participante
**Atividade 05 - Programação para Dispositivos Móveis**

---

### 1. Tela de Cadastro
Organize os seguintes campos em um `Form`, na ordem apresentada:

| Campo | Regras de validação | Tipo de teclado |
|---|---|---|
| **E-mail** | Obrigatório e com estrutura básica válida, como `ana@email.com`. | `TextInputType.emailAddress` |
| **Nome** | Obrigatório, com pelo menos três caracteres após remover os espaços das extremidades. | `TextInputType.name` |
| **Telefone** | Obrigatório, no formato `DD-DDDDD-DDDD`. | `TextInputType.phone` |
| **CPF** | Obrigatório, contendo exatamente onze dígitos, sem pontos ou traço. Não é necessário verificar os dígitos verificadores. | `TextInputType.number` |

- No campo **Telefone**, apresente o formato esperado por meio de `hintText`. O usuário deverá digitar os separadores; não é necessário implementar uma máscara automática.
- Configure os campos **E-mail**, **Nome** e **Telefone** com `TextInputAction.next`, permitindo avançar ao próximo campo pela ação do teclado.
- No campo **CPF**, utilize `TextInputAction.done` e `onFieldSubmitted` para executar a mesma operação do botão *Exibir dados*.

**A tela deverá possuir dois botões:**
- **Exibir dados:** validar todos os campos e abrir a segunda tela somente quando os dados forem válidos.
- **Limpar:** apagar os textos, remover as mensagens de validação e retirar o foco do campo ativo.

---

### 2. Tela de Resumo
Crie uma classe `Participante` com os atributos imutáveis `email`, `nome`, `telefone` e `cpf`, todos do tipo `String`. 

Após validar o formulário, crie um objeto dessa classe e envie-o pelo construtor da tela de resumo. Apresente os quatro dados e inclua o botão **Voltar para editar**, que deverá retornar ao formulário mantendo os campos preenchidos.

---

### 3. Requisitos de Implementação
* Criar uma `GlobalKey<FormState>` e um `TextEditingController` para cada campo como atributos do estado.
* Definir uma função de validação para cada campo, retornando uma mensagem em caso de erro e `null` quando o valor for válido.
* Ler os dados pelos controladores e aplicar `trim()` antes de criar o objeto.
* Descartar todos os controladores em `dispose()`.
* Utilizar `const` sempre que possível.
