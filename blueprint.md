# Visão Geral do Projeto

Este é um aplicativo de calculadora simples construído com Flutter. Ele permite que os usuários executem expressões matemáticas básicas, incluindo adição, subtração, multiplicação e divisão. O aplicativo também inclui recursos como um ponto decimal, parênteses, e a capacidade de limpar a entrada, apagar caracteres e alterar o sinal de um número. O tratamento de erros para expressões inválidas e erros matemáticos (como divisão por zero) está incluído.

# Plano de Implementação Atual

O plano para criar o aplicativo de calculadora é o seguinte:

1.  **Configurar o Projeto:** Adicionar as dependências necessárias (`math_expressions`).
2.  **Construir a Interface do Usuário (UI):**
    *   Criar um layout para a calculadora em `lib/main.dart`.
    *   A UI consistirá em uma área de exibição para a expressão e o resultado, e uma grade de botões.
    *   Os botões incluirão:
        *   Números de 0 a 9.
        *   Operadores: +, -, \*, /.
        *   Ponto decimal: ..
        *   Parênteses: ( ).
        *   Limpar tudo: C.
        *   Apagar: <.
        *   Trocar sinal: +/-.
        *   Igual: =.
3.  **Implementar a Lógica da Calculadora:**
    *   Gerenciar a entrada do usuário e anexar aos botões pressionados na string da expressão.
    *   Implementar a funcionalidade para os botões de `apagar`, `limpar tudo` e `trocar sinal`.
    *   Quando o botão `=` for pressionado, usar o pacote `math_expressions` para avaliar a string da expressão.
    *   Implementar um tratamento robusto de erros para capturar e exibir mensagens para entradas inválidas (ex: `SyntaxError`), divisão por zero e outros erros matemáticos.
4.  **Estilizar o Aplicativo:**
    *   Aplicar um tema `Material Design` limpo e moderno.
    *   Garantir que os botões sejam bem espaçados e fáceis de pressionar.
    *   Usar fontes e cores apropriadas para uma boa legibilidade.
