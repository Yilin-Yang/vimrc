#!/bin/bash

# EFFECTS:  Installs the Project Gutenberg thesaurus, default vim spellfile,
#           and a dictionary into the appropriate .vim folders.

source "`dirname $0`/global_constants.sh"

# Project Gutenberg Thesaurus - http://www.gutenberg.org/ebooks/3202
THESAURUS_DIR=$DIR/thesaurus
THESAURUS=$THESAURUS_DIR/mthesaur.txt
mkdir -p $THESAURUS_DIR
if [ ! -f $THESAURUS ]; then
    curl http://www.gutenberg.org/files/3202/files/mthesaur.txt > $THESAURUS
fi

# english-words.git - https://github.com/dwyl/english-words
DICTIONARY_DIR=$DIR/dictionary
DICTIONARY=$DICTIONARY_DIR/english.dict
mkdir -p $DICTIONARY_DIR
if [ ! -f $DICTIONARY ]; then
    curl https://raw.githubusercontent.com/dwyl/english-words/master/words.txt > $DICTIONARY
fi
