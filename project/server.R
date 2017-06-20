library(UsingR)
source("nextword.R")

shinyServer(  
    function(input, output) {    
        lastSubmit<-0
        helpText = "This app calculates the Investment, in terms of dollar amounts, after a few years.  It will provide the final amount, and the a graph throughout the years as your investment grows.  To run this, please enter the rate of return, the years to invest, and the initial investment in terms of dollars.  Values are automatically calculated upon hitting enter.  Note that it is limited to 1-50 years with a maximumn of $1M"
        output$newInvestment <- renderPlot({ 
            lastYear <- 2016 + input$years - 1
            years = c(2016:lastYear)
            dollars<-c(1:input$years)
            
            for (i in dollars) {
                dollars[i] = input$startCash * (1+input$rate/100)^i
            }
            
            names(dollars) <- years
            barplot(dollars, xlab="Year", ylab="Dollar Amount", 
                    col='lightblue', main="Dollar Amount per year")
           
        })
        output$newFinal<-({
            renderText({paste("Final Amount $", input$startCash * round((1+input$rate/100)^input$years, 2))})
        })

        output$helpText <- renderText({
            if (input$help %% 2== 1) { isolate({HTML(helpText)})}
        })
        
        output$nextWord<-renderText({
            if (input$submit > lastSubmit) {
                lastSubmit = input$submit
                return(processSentence(input$sentence, input$fast))
            } 
        })
        
    }
    
)