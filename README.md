# Frequency-Guided Word Substitutions for Detecting Textual Adversarial Examples

Source code for our [paper](https://www.aclweb.org/anthology/2021.eacl-main.13/) *Frequency-Guided Word Substitutions for Detecting Textual Adversarial Examples* (EACL 2021).

## Requirements
* pillow (8.2.0)
* pytorch (1.8.1)
* numpy (1.20.2)
* scikit-learn (0.24.1)
* nltk (3.6.2)
* tensorboardX (2.2)
* transformers (4.5.1)
* statsmodels (0.12.2)
* spacy (3.0.5)

The code is built in Python 3.7.7. To install all required packages, run 
```
pip install -r requirements.txt
```

## Obtaining the data
To download the necessary datasets and pre-trained embeddings, run
```
cd data
sh download_data.sh
```

## Train/test a model
Now you can train a model by running 
```
python3 main.py -dataset imdb -model_type roberta -gpu 
```
The `-gpu` flag should be removed when no GPU is available. See `config.py` for other dataset and model options.

A trained model can be tested by running 
```
python3 main.py -dataset imdb -model_type roberta -gpu -mode test
```

## Attack a model
Once you have trained a model, run 
```
python3 attack_models.py -mode attack -dataset imdb -model_type roberta -gpu -limit 2000 -attack random
```
The `-gpu` flag should be removed when no GPU is available. See `config.py` for other dataset, attack and model options.

## Detect adversarial examples
Finally, adversarial sequence detection can be done. 

First, for FGWS we need to tune delta on the validation set. Run 
```
python3 attack_models.py -mode attack -dataset imdb -model_type roberta -gpu -limit 2000 -attack prioritized -attack_val_set

python3 detect.py -mode detect -dataset imdb -model_type roberta -gpu -limit 2000 -attack prioritized -fp_threshold 0.9 -tune_delta_on_val
```
to tune the parameter.

For testing with FGWS, run 
```
python3 detect.py -mode detect -dataset imdb -model_type roberta -gpu -limit 2000 -attack random -fp_threshold 0.9
```
For NWS, run 
```
python3 detect.py -mode detect -dataset imdb -model_type roberta -gpu -limit 2000 -attack random -fp_threshold 0.9 -detect_baseline
```

## References
If you find this repository useful, please consider citing our paper:
```
@inproceedings{mozes-etal-2021-frequency,
    title = "Frequency-Guided Word Substitutions for Detecting Textual Adversarial Examples",
    author = "Mozes, Maximilian  and
      Stenetorp, Pontus  and
      Kleinberg, Bennett  and
      Griffin, Lewis",
    booktitle = "Proceedings of the 16th Conference of the European Chapter of the Association for Computational Linguistics: Main Volume",
    month = apr,
    year = "2021",
    address = "Online",
    publisher = "Association for Computational Linguistics",
    url = "https://www.aclweb.org/anthology/2021.eacl-main.13",
    pages = "171--186"
}
```