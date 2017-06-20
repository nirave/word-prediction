shinyUI(fluidPage(
    titlePanel("Word Prediction App"),
    sidebarPanel(
        h4("Predict the next word.."),
        textInput("sentence", label=h3("Enter a sentence"), value=""),
        actionButton("submit", "Submit"),
        checkboxInput("fast", "Fast prediction (but less reliable)", TRUE)
    ),

    mainPanel(
        tabsetPanel(type = "tabs", 
            tabPanel("Prediction", mainPanel(
                textOutput('nextWord')
                )
            ), 
            tabPanel("Help/Explanation", mainPanel(
                h2("Help"),
                p("Enter a series of words in the search box to predict the next word"),
                p("If you want a faster prediction, click the box labelled Fast Prediction"),
                p("If reliability is more of a concern, uncheck that box.  By unchecking it,
                  the algorithm will use more words and a more complex algorithm."),
                h2("Explanation"),
                p("Using a sample of text from blogs, twitter feeds, 
                  and news, this takes in the next page and predicts the next word.  
                  This sample is taken from SwiftKey.  And since computational power 
                  is limited, only 10% of the sample is used."),
                p("Prediction is done through looking at trigrams, bigrams, and unigrams, 
                  using simple markov chains to determine the order"),
                p("In addition, if Fast prediction is not selected, an additional 
                   trigram search will be done on a consecutive n-gram to determine
                   if previous words in the sentence yield better results.  This, unfrotunately,
                   adds significant time (especially if the sentence is long), and is included
                   as an option.")
                )
            )
    )
)))