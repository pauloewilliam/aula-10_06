Diferença entre Construtor Padrão e Construtor Factory:
O construtor padrão é usado para criar um objeto novo toda vez que é chamado. Por exemplo, quando criamos um ServiceOrder com nome, status e descrição, ele simplesmente pega esses valores e monta o objeto.
Já o construtor factory não cria necessariamente um objeto novo. Ele pode retornar um objeto que já existe na memória, ou pode ter uma lógica antes de criar o objeto. No projeto usamos o fromJson para pegar um Map (que simula um JSON de uma API) e transformar em um objeto ServiceOrder.
Quando usar cada um: Construtor padrão: quando só precisa criar um objeto simples com seus dados
Factory: quando precisa converter dados (como JSON), ou quando quer garantir que só existe um objeto na memória (Singleton)

O que é Singleton:
Singleton é um padrão que garante que uma classe tenha apenas uma única instância durante toda a execução do app. No projeto, a classe Database usa esse padrão, então não importa quantas telas tentem criar um Database(), todas vão receber o mesmo objeto. Isso é importante para que os dados adicionados em uma tela apareçam em todas as outras.

O que acontece na linha 134 e a finalidade do setState:
O setState serve para avisar o Flutter que algo mudou e que ele precisa atualizar a tela. Sem ele, mesmo que a lista receba novos dados, o usuário não veria a mudança na tela.
Na linha 134 especificamente, o setState adiciona a nova ordem de serviço no Database e atualiza a lista local, fazendo com que o ListView mostre o novo item imediatamente sem precisar sair e entrar na tela de novo.