# Superpixel-based online wagging one-class ensemble for feature selection in foreground/background separation

Last Page Update: **19/03/2018**


We present a novel online one-class ensemble based on wagging  to select suitable features to each region of a certain scene to distinguish the foreground objects from the background. In addition, we propose a mechanism to update the importance of each feature discarding insignificantly features over time. 

HIGHLIGHTS

* A novel methodology to select the best features based on wagging.
* A superpixel segmentation strategy to improve the segmentation performance, increasing the computational efficiency of our ensemble.
* A mechanism called Adaptive Importance Computation and Ensemble Pruning (AIC-EP) to suitably update the importance of each feature discarding insignificantly features over time.

BRIEF OVERVIEW OF THE PROPOSED FRAMEWORK
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/Superpixel-OWAOC/master/docs/eensemble_proposed2.png" border="0" /></p>

ALGORITHM: THE WAGGING FOR FEATURE SELECTION 
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/Superpixel-OWAOC/master/docs/algorithm.png" border="0"/></p>

BACKGROUND SUBTRACTION RESULTS ON RGB-D DATASET​​​​​​​​​​​​​​
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/Superpixel-OWAOC/master/docs/rgbd_imp_features.png" border="0" /></p>


Citation
--------
If you use this code for your publications, please cite it as:
```
@inproceedings{silva Carolinr,
author    = {Silva, Caroline and Bouwmans, Thierry and Frelicot, Carl},
title     = {Superpixel-based incremental wagging one-class ensemble for feature selection in foreground/background separation},
booktitle = {Pattern Recognition Letters (PRL)},
year      = {2017},
url       = hhttps://www.sciencedirect.com/science/article/pii/S0167865517304038}
}
``
