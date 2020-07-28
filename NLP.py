# If you don't have nltk installed comment all the code under the bar and run the following:

# import nltk
# nltk.download()

# -------------------------------------------------------------------
import os

import numpy as np
import tensorflow as tf

import tensorflow_hub as hub
import tensorflow_datasets as tfds
tfds.disable_progress_bar()

from official.modeling import tf_utils
from official import nlp
from official.nlp import bert
# from PyDictionary import PyDictionary
# Load the required submodules
import official.nlp.optimization
import official.nlp.bert.bert_models
import official.nlp.bert.configs
import official.nlp.bert.run_classifier
import official.nlp.bert.tokenization
import official.nlp.data.classifier_data_lib
import official.nlp.modeling.losses
import official.nlp.modeling.models
import official.nlp.modeling.networks

# Synonym Generation
from nltk.corpus import wordnet

# Regex
import re
def getSynonyms(word):
            # Create List to hold the synonyms;
            synonyms = []
            # The term synset stands for "set of synonyms". 
            # A set of synonyms is a set of words with similar
            # meaning, e.g. ship, skiff, canoe, kayak might 
            # all be synonyms for boat. In the nltk, a synset
            # is in fact a set of lemmas with related meaning. 
            for syn in wordnet.synsets(word):
                        # A lemma is wordnet's version of an entry in a dictionary:
                        # A word in canonical form, with a single meaning. E.g., if
                        # you wanted to look up "banks" in the dictionary, the canonical 
                        # form would be "bank" and there would be separate lemmas for 
                        # the nouns meaning "financial institution" and "side of the river",
                        # a separate one for the verb "to bank (on)", etc.
                        for l in syn.lemmas():
                                    synonyms.append(l.name().replace("_"," "))
            return synonyms

def processQuery(string):
    if(re.sub(r'[^\w\s]', '', string.lower()) == "what are your capabilities"):
                return "I can provide information on court cases based on specific cases as well as find laws and determine if something is legal or not [experimental]"
    # BERT setup folder
    gs_folder_bert = "gs://cloud-tpu-checkpoints/bert/keras_bert/uncased_L-12_H-768_A-12"
    tf.io.gfile.listdir(gs_folder_bert)
    hub_url_bert = "https://tfhub.dev/tensorflow/bert_en_uncased_L-12_H-768_A-12/2"
    glue, info = tfds.load('glue/mrpc', with_info=True,
                        # It's small, load the whole dataset
                        batch_size=-1)
    # Set up tokenizer to generate Tensorflow dataset
    tokenizer = bert.tokenization.FullTokenizer(
        vocab_file=os.path.join(gs_folder_bert, "vocab.txt"),
        do_lower_case=True)
    tokens = tokenizer.tokenize(string)
    ids = tokenizer.convert_tokens_to_ids(tokens)
    cnt = 0;
    tags = []
    for ele in ids:
            if ele > 3000:
                        # Append token to tag if token value above 3000 (uncommon words)
                        tags.append(tokens[cnt])
            cnt += 1
    end = []
    print(tags)
    for tag in tags:
                # Get all synonyms
                end.append(getSynonyms(tag))
    return tags + end

# Example Run
# print(processQuery("What are your capabilities?"))
