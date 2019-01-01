## RANS_Channel

The source codes available here are based on the [publication:](https://www.sciencedirect.com/science/article/pii/S0142727X18301978)
[![paper](https://github.com/Fluid-Dynamics-Of-Energy-Systems-Team/RANS_Channel/blob/master/paper.png)](https://www.sciencedirect.com/science/article/pii/S0142727X18301978)

The codes solve the Reynolds-averaged Navier-Stokes equaitons for a fully developed turbulent channel flow with varying properties, such as density and viscisity. The code demonstrates how to modify existing turbulence model to properly account these thermophysical property variations.

They are available as
* matlab (matlab/main.m) and
* python source in form of a jupyter notebook ([main.ipynb](https://github.com/Fluid-Dynamics-Of-Energy-Systems-Team/RANS_Channel/blob/master/main.ipynb)). 

## Requirements

* matlab
* Anaconda 


## Execution

Either run the matlab file main.m, or execute the jupyter notebook. The codes run cases for which DNS data is available to compare with. The DNS data is given in the directory [DNS_data](https://github.com/Fluid-Dynamics-Of-Energy-Systems-Team/RANS_Channel/tree/master/DNS_data), which are based on this [publication](http://pure.tudelft.nl/ws/files/22297028/PecnikPatel.pdf).







