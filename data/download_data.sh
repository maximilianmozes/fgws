# Setup directory structure
mkdir -p data/imdb
mkdir -p data/pretrained
mkdir -p models/test
mkdir -p attacks
mkdir -p detections

# Download IMDb dataset
cd data/imdb
wget https://ai.stanford.edu/~amaas/data/sentiment/aclImdb_v1.tar.gz
tar -zxvf aclImdb_v1.tar.gz
rm aclImdb_v1.tar.gz
mv aclImdb/* .
rm -rf aclImdb
cd ../..

# SST-2
# Downloaded from https://gluebenchmark.com/tasks, https://github.com/CS287/HW1/tree/master/data

# Download GloVe embeddings for training
cd data/pretrained
mkdir gloVe
cd gloVe
wget http://nlp.stanford.edu/data/glove.42B.300d.zip
unzip glove.42B.300d.zip
rm glove.42B.300d.zip
cd ../../..

# Download counter-fitted embeddings for Genetic attack
# Script adapted from https://github.com/nesl/nlp_adversarial_examples/blob/master/download_counterfitted_vectors.sh
cd data/pretrained
mkdir counter-fitted
cd counter-fitted
wget https://raw.githubusercontent.com/nmrksic/counter-fitting/master/word_vectors/counter-fitted-vectors.txt.zip
unzip counter-fitted-vectors.txt.zip
rm counter-fitted-vectors.txt.zip

# Download spaCy dependency
python -m spacy download en_core_web_sm
