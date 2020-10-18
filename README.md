# Three Planets Simulation :earth_africa:
(Simple) simulation of the dynamics of 3 planets interacting with each other, due to gravitational attraction.

To change the initial conditons of the simulation, change the parameters in the first section:
```
mi = ...;                              % the ith mass
xi0 = ...; yi0 = ...; zi0 = ...;       % initial coordinates of the ith body
vxi0 = ...; vyi0 = ...; vzi0 = ...;    % initial velocity of the ith body
```

The program solve a system of coupled ODEs obtained using a simple model, where the acceleration of the i-th mass only depends on the gravitational force of the other masses:

<a href="https://www.codecogs.com/eqnedit.php?latex=\vec{F}_{ij}&space;=&space;-\sum_j&space;G\frac{m_i&space;m_j}{\left&space;\|&space;\vec{x}_i-\vec{x}_j&space;\right&space;\|^{3/2}}(\vec{x}_i-\vec{x}_j)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\vec{F}_{ij}&space;=&space;-\sum_j&space;G\frac{m_i&space;m_j}{\left&space;\|&space;\vec{x}_i-\vec{x}_j&space;\right&space;\|^{3/2}}(\vec{x}_i-\vec{x}_j)" title="\vec{F}_{ij} = -\sum_j G\frac{m_i m_j}{\left \| \vec{x}_i-\vec{x}_j \right \|^{3/2}}(\vec{x}_i-\vec{x}_j)" /></a>

The code generates an avi-format video. Some examples are provided in the repository.
