# SY09 théorie

### Question 1
On note $p_{kj} = Pr(X^j = 1 | Z = w_k)$. Il s'agit de la proportion d'individus dans la classe $w_k$ avec $X^j$ d'une valeur égale à 1.

Etant donné $Z$, $X^j$ suit une loi de Bernouilli de paramètre $p_{kj}$. 
On peut donc écrire : $Pr(X^j = x_j | Z = w_k) = (p_{kj})^{x_j}(1-p_{kj})^{(1-x_j)}$ avec $x_j = \{0, 1\}$.

### Question 2

On note $x = (x_1, x_2, ..., x_p)^T$ une réalisation de $X$. 

$Pr(X = x | Z = w_k) = Pr(X^1 = x_1 \cap X^2 = x_2 \cap \ldots \cap X^p = x_p | Z = w_k)$

Par indépendance, on peut écrire la chose suivante: 
$Pr(X = x | Z = w_k) = Pr(X^1 = x_1 | Z = w_k) * Pr(X^2 = x_2 | Z = w_k) * \ldots * Pr(X^p = x_p | Z = w_k)$
$Pr(X = x | Z = w_k) = \prod^p_{j = 1} Pr(X^j = x_j | Z = w_k)$

### Question 3

$Pr(X = x_i, Z = z_i) = Pr(X = x_i | Z = z_i) * Pr(Z = z_i)$

$Pr(Z = z_i) = z_{i1} * \pi_1 + ... + z_{ig} * \pi_g$
$Pr(Z = z_i) = z_{i1} * \sum^n_{i=1}z_{ik}\pi_k$

D'où : 
$Pr(X = x_i, Z = z_i) = Pr(X = x_i | Z = z_i) * \sum^n_{i=1}z_{ik}\pi_k$

D'après la question 2 : 
$Pr(X = x_i, Z = z_i) = \prod^p_{j = 1} Pr(X^j = x_{j} | Z = w_k) * \sum^n_{i=1}z_{ik}\pi_k$

D'après la question 1 : 
$Pr(X = x, Z = z_i) = \prod^p_{j = 1} (p_{kj})^{x_j}(1-p_{kj})^{(1-x_j)} * \sum^n_{i=1}z_{ik}\pi_k$


### Question 4

$L(p_{kj}, \pi_k; (x_1, z_1), ... (x_n, z_n)) = \prod^n_{i = 1} Pr(X = x_i, Z = z_i)$

$L(p_{kj}, \pi_k; (x_1, z_1), ... (x_n, z_n)) = \prod^n_{i = 1} \prod^p_{j = 1} (p_{kj})^{x_j}(1-p_{kj})^{(1-x_j)} * \sum^n_{i=1}z_{ik}\pi_k$
