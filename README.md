[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

# Feature Selection with Nearest Neighbor
This preject enhances speed and performance of greedy search based feature selection, which reduces k-NN sensitivity when dealing with classification problems, through integrating with resampling and pruning.

## Background
The classification problem can be expressed as: Given a training database, predict the class label of a previously unseen instance. The [k-nearest neighbors algorithm (k-NN)](https://en.wikipedia.org/wiki/K-nearest_neighbors_algorithm) is simple, yet very competitive solution to this problem. But k-NN is hopelessly confused by irrelevant attributes, thus with enough irrelevant attributes, k-NN becomes no better than random guessing. 

To mitigate k-NN sensitivity to irrelevant features, we may consider using more training instances or asking an expert what features are relevant to the task, a more expensive but smarter option is to "wrap" the attribute selection around the learner itself, with a [hill-climbing search](https://en.wikipedia.org/wiki/Hill_climbing) over the subsets of features. Using [K-fold cross validation](https://en.wikipedia.org/wiki/Cross-validation_(statistics)) is a good way to choose the subset of features we need to adjust in the classifier. But we may find it hard to find the weak feature, and also may find spurious features.

Therefore, I generate a algorithm that not only solves these problems but also speed up search by introducing [alpha-beta pruning](https://en.wikipedia.org/wiki/Alpha–beta_pruning) and resampling. To compare greedy forward selection search, greedy backward elimination search and my original feature search algorithm, they were tested on several [datasets](tests/README.md). Read my [report](report.pdf) for details.

## Usage
This project is tested on MacOS with Matlab R2019a and Windows with Matlab R2018b. 

In Matlab, change Current Folder to "src".

In Command Window
 ```sh
 >> Feature_Selection_with_Nearest_Neighbor
 ```
 Then follow the instructions on the screen.