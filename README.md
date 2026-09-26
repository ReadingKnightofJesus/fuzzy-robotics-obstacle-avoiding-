# fuzzy-robotics-obstacle-avoiding

Documento explicativo de um sistema Fuzzy para desvio de obstáculos de um robô. O sistema é responsável por permitir que um robô desvie de obstáculos, entregando um ângulo de direção na saída. O projeto é parte das pendências da disciplina de Automação Inteligente do curso de Engenharia Elétrica do IFBA - Campus Vitória da Conquista, sendo efetuado por David Manhães Magalhães

## 1 - Pré-Requisitos

O código pode ser reutilizado tanto no Matlab quanto em outros aplicativos similares, desde que contenham um setup semelhante. Recomenda-se a utilização do seguinte sistema, a qual foi a base para o desenvolvimento e validação:

* GNU Octave - 8.4.0
* GNU Octave Package: fuzzy-logic-toolkit - 0.6.2

### 1.1 - Como Instalar as Dependências

O Octave é a dependência básica para o funcionamento do projeto, podendo facilmente ser instalado a partir do tutorial disponibilizada pela site oficial do software, [acessando este link](https://octave.org/download)

Com o Octave ***instalado***, também é necessário a instalação do pacote referente ao fuzzy-logic-toolkit, que nos dá as principais funções do nosso projeto. Ela pode ser obtida a partir do terminal do GNU Octave, rodando o seguinte comando:

``` Matlab
pkg install -forge fuzzy-logic-toolkit
```

## 2 - Variáveis de Entrada e Saída

O código espera-se um robô que contenha as seguintes características de sensores referentes á detecção de obstáculos:

* Um sensor frontal que mede a distância frontal;
* Um sensor lateral ou um conjunto de sensores que medem a assimetria lateral;

Esse conjunto nos dá um sistema de duas entradas e uma saída, sendo explicadas a seguir

### Entrada - Distância Frontal

A nossa primeira entrada é refere-se á distância frontal medida pelo robô, possuindo as seguintes características:

* Universo de discurso: d ∈ [0, 100] cm
* Termos linguísticos: {Perto, Média, Longe}

![Primeira Entrada](/prints/entrada1.png)

### Entrada - Distância Lateral

A nossa segunda entrada apresenta a assimetria lateral do obstáculo medido, relacionada ao centro do robô, com as seguinte características de entrada:

* Universo de discurso: a ∈ [−50, 50] cm (valores negativos = obstáculo mais próximo do lado direito). 
* Termos linguísticos: {Negativa, Zero, Positiva}

![Segunda Entrada](/prints/entrada2.png)

### Saída - Ângulo de Direção

A saída é representada pelo ângulo da correção de direção do robô

* Universo de discurso: θ ∈ [−45°, 45°] (negativo = virar à esquerda, positivo = virar à direita). 
* Termos linguísticos: {Virar Esquerda, Seguir em Frente, Virar Direita}

![Saída](/prints/saida.png)

## Conjunto de Regras

As regras utilizadas seguem o padrão "Se (distância frontal é X) E (assimetria é Y) então (ângulo é Z)", com o conectivo E implementado pelo operador Mínimo. A tabela abaixo expõe as 9 regras do sistema:

| Frontal \ Assimetria | Negativa | Zero | Positiva |
| --- | --- | --- | --- |
| **Perto** | Virar Esquerda | Virar Direita | Virar Direita |
| **Média** | Virar Esquerda | Seguir em Frente | Virar Direita |
| **Longe** | Seguir em Frente | Seguir em Frente | Seguir em Frente |

## Execução do Código

Com este repositório baixado no computador, navegue até a pasta a partir do file browser do octave (O terminal também pode ser utilzado para navegação com o comando cd)

O código principal é uma função que recebe dois valores, por isso, ele pode ser processado de forma simples utilizando o seguinte comando no terminal do Octave

``` Matlab
code(distancia_frontal, assimetria_lateral)
```

No terminal será apresentado o valor calculado

## Resultados

Segue o seguinte exemplo de execução com distancia_frontal = 10cm e assimetria_lateral = -10cm

![Resultado](/prints/resultado.png)