# Test Cases

## Format
|||
|-|-|
| Row | Instance |
| Column | <li> Class labels are in the first column, either a '1' or '2' <br> <li> The second column up to the last column are the features <br> <li> Space delimited
| Data | Numbers are in [standard IEEE 754-1985](https://en.wikipedia.org/wiki/IEEE_754-1985), single precision format  |

## Size
- SMALLtestdata__*.txt has 200 instances and 10 features.
- LARGEtestdata__*.txt has 200 instances and 100 features.

## Checkpoints
- Expected results for 3 small datasets
    1. On [SMALLtestdata__108.txt](SMALLtestdata/SMALLtestdata__108.txt) the error rate can be 0.91 when using only features 6  5  4
    2. On [SMALLtestdata__109.txt](SMALLtestdata/SMALLtestdata__109.txt) the error rate can be 0.89 when using only features 7  9  2
    3. On [SMALLtestdata__110.txt](SMALLtestdata/SMALLtestdata__110.txt) the error rate can be 0.925 when using only features 6  4  9

- Expected results for 3 large datasets
    1. On [LARGEtestdata__108.txt](LARGEtestdata/LARGEtestdata__108.txt) the error rate can be 0.93 when using only features 46  26  95
    2. On [LARGEtestdata__109.txt](LARGEtestdata/LARGEtestdata__109.txt) the error rate can be 0.925 when using only features 72  19   2
    3. On [LARGEtestdata__110.txt](LARGEtestdata/LARGEtestdata__110.txt) the error rate can be 0.935 when using only features 1  66   6