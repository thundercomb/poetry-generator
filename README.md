poetry-generator
================

This is a fork of [Zackary Scholl's excellent Poetry Generator](https://github.com/schollz/poetry-generator). It now runs as Ruby rather than Python. I've also added new data.

Poetry Generator is a data driven process and most of the work goes into crafting the bnf dataset. Backus-Naur Form is a type of context-free grammar. For development purposes it functions a lot like parameterised templating. Decent results can be generated, as Scholl's original demonstrates. Almost everything depends on the quality of the dataset and its formalisation. 

Particular data files can be run as follows:

ruby poem.rb <dataset>

eg.

ruby poem.rb shakespeare.bnf

At the moment two datasets are available:

1. scholl.bnf: Zackary Scholl's [original] (http://www.zackaryscholl.com/programming/poetry-generator/poem.php)
2. shakespeare.bnf: Derived from a selection of Shakespeare sonnets
