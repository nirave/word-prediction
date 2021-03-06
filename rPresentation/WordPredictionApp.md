Word Prediction Application - JHU Data Science Capstone Project 
========================================================
author: Nirave Kadakia
date: June 19, 2016

Word Prediction Application
========================================================

Introduction

- With the proliferation of mobile devices with small keyboards, word prediction is increasingly needed for today's technology
- Using SwiftKey's sample data set and R, this app takes that sample data and uses it to predict the next word in a phrase/sentence


Usage

- Available at: https://nirave.shinyapps.io/capstone/
    + Just type in a sentence and it will give, in order of best to worst, the top ten predicted words
    + There is a fast, and less reliable, prediction model - just click "Fast Prediction" and click "Submit"
    + or there is an option for a slower, slightly more reliable prediction algorithm - just unclick "Fast Prediction" and click "Submit"


Getting and Cleaning Data
========================================================

- Data is gathered from: https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip
    + Consists of sample blogs, tweets, and news articles in English
    + Approximately 40 million words in over 2 million lines
- R, with libraries rWeka and tm, are used to do the following:
    + Create a corpus of 10% of the documents
        + Since computational power is limited, this was done in 1% increments
    + Construct unigrams, bigrams, and trigrams
    + Create data frames containing a column for each word, and one column for the number of observations for quick lookup


Word Prediction Algorithm
========================================================

- Trigrams, Bigrams, and Unigrams are constructed
- Last two words are looked at in the Trigram data frame
    + Possible third words are computed - with scores higher, via a simplified markov chain, are given first
- Markov chain is calculated as P(w3, w2, w1| w2, w1) for each possible value found in the trigram lookup
    + That equation is the probability of trigram of for word 3, with word 2 and word 1 preceding, given the probability of word 2 with word 1 preceding it
    + This is simplified by using the counts of word 1 + word 2 + word 3 in the trigram divided by the count of word 1 + word 2 in the bigram
- If there are no trigram matches, bigrams with the highest count is given
- If there are no bigram matches, the top 10 unigram words are presented
  

Word Prediction Algorithm (slow)
========================================================
- If "Fast Prediction" is not selected, an extra algorithm will be introducted
- Often times, this will yield slightly better results, but most likely will not be worth the extra time
- This computes the next words the same way as before, but also adds an additional check by gathering predicted trigrams of previous words in the sentence, and if unusual words that match the predicted trigrams are present, those words are bumped up.  
    + Unusual words are classified as words with less than 100 occurances in the sample corpus
    + This was useful for adding more specific words and reducing simple stop words
- Since it slowed down the app considerable, it is an optional layer of intelligence to the app.

Performance
========================================================
- Due to the large dataset, the markov calculations, and the bigram secondary calculation, it takes approximately 3 seconds to predict the next word.
- With an extra algorithm ("Fast Prediction" unchecked), it takes approximately 11 seconds to predict the next word.
- If time is of the absolute essence, simple lookups of trigrams and bigrams can be done without any added algorithms.  Times measurements are done in milliseconds.  If such a desire is requested, a secondary, yet simpler, deployment was done at: https://nirave.shinyapps.io/shiny/
