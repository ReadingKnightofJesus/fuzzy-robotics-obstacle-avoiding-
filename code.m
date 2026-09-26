function angulo_saida = controlador(distancia_frontal, assimetria_lateral)
  # Script para Lógica Fuzzy - GNU OCTAVE

  # Setup Inicial
  pkg load fuzzy-logic-toolkit
  fis = newfis('avoidance');

  entrada = [distancia_frontal, assimetria_lateral];


  # Adicionando e Configurando a Primeira Entrada - Distância Frontal
  fis = addvar(fis, 'input', 'Distancia_Frontal', [0 100]);
  fis = addmf(fis, 'input', 1, 'Perto', 'trapmf', [-5 0 15 40]);
  fis = addmf(fis, 'input', 1, 'Média', 'trimf', [15 50 85]);
  fis = addmf(fis, 'input', 1, 'Longe', 'trapmf', [60 85 100 105]);
  # plotmf(fis,"input",1)


  # Adicionando e Configurando a Segunda Entrada - Distância Lateral
  fis = addvar(fis, 'input', 'Distancia_Lateral', [-50 50]);
  fis = addmf(fis, 'input', 2, 'Negativa', 'trapmf', [-55 -50 -25 0]);
  fis = addmf(fis, 'input', 2, 'Zero', 'trimf', [-25 0 25]);
  fis = addmf(fis, 'input', 2, 'Positiva', 'trapmf', [0 25 50 55]);
  # plotmf(fis,"input",2)


  # Adicionando e Configurando a Saída -
  fis = addvar(fis, 'output', 'Angulo_de_Direção', [-45 45]);
  fis = addmf(fis, 'output', 1, 'Virar_Esq', 'trapmf', [-50 -45 -20 0]);
  fis = addmf(fis, 'output', 1, 'Seguir', 'trimf', [-20 0 20]);
  fis = addmf(fis, 'output', 1, 'Virar_Dir', 'trapmf', [0 20 45 50]);
  # plotmf(fis, "output", 1)


  # Definindo as Regras do Sistema
  regras = [
      # Conjunto de Regras/
      # [Entrada1   Entrada2   Saída   Peso   Operador]

      # Frontal = Perto (1) | Lateral | Então:
      1, 1, 1, 1, 1;
      1, 2, 3, 1, 1;
      1, 3, 3, 1, 1;

      # Frontal = Média (2) | Lateral | Então:
      2, 1, 1, 1, 1;
      2, 2, 2, 1, 1;
      2, 3, 3, 1, 1;

      # Frontal = Longe (3) | Lateral | Então: Seguir
      3, 1, 2, 1, 1;
      3, 2, 2, 1, 1;
      3, 3, 2, 1, 1;
  ];

  fis = addrule(fis, regras);


  # Defuzzificação
  angulo_saida = evalfis(entrada, fis);

  disp(['Ângulo de direção calculado: ', num2str(angulo_saida), ' graus']);

endfunction