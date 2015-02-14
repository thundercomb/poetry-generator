poetry-generator
================

This is a fork of [schollz' excellent poetry generator](https://github.com/schollz/poetry-generator)

The main logic has been changed to Ruby, as my scripting language of choice.

The aim of this fork is to experiment with and extend the dataset, which employs Backus-Naur Form.

Zackary Schollz explains his Poetry Generator as follows (edited for the Ruby conversion):

This program works on the basis that every word in the English language is either "positive" or "negative." For instance "lovely" is positive and "thorn" is negative. A "poem" is a group of sentences that are structured in a way to have +1, -1 or 0 in terms of the positivity/negativity.  A "mushy poem" is strictly positive.

All the syntax and word choices are in the ```poem.bnf``` file. The main program is in ```poem.rb``` and for web applications use the ```poem.php``` script to automatically generate a poem onload!

Try the [demo here](http://www.zackaryscholl.com/programming/poetry-generator/poem.php)
