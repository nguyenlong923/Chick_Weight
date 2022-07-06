#
# This is the server logic of a Shiny web application that submitted for the 
# final Assignment of the Developing Data Products course. You can run the 
# application by clicking 'Run App' above.
#


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$out  <- renderText({
paste("
This Shiny web application is to analyse the Chick Weight data.

The ChickWeight data frame has 578 rows and 4 variables from an experiment 
on the effect of diet on early growth of chicks:
- weight: a numeric vector giving the body weight of the chick (gm).
- Time: a numeric vector giving the number of days since birth when the 
measurement was made.
- Chick: an ordered factor with levels 18 < ... < 48 giving a unique 
identifier for the chick. The ordering of the levels groups chicks on the 
same diet together and orders them according to their final weight 
(lightest to heaviest) within diet.
- Diet: a factor with levels 1, ..., 4 indicating which experimental diet 
the chick received.

This application will fit a linear model of weight versus age of chicks 
and predict the weight. You can:
1) Change the age (days since birth) by sliding
2) Choose to account for the effects of different diet by click on 
Show/Hide Diet
After choosing the option, please click the button Execute to start the
applicaton.

Please find the source code here: 
https://github.com/nguyenlong923/Chick_Weight
      ", sep="\n")
    })
    data("ChickWeight")
    modelAll <- lm(weight ~ Time, data=ChickWeight)
    model1 <- lm(weight ~ Time, data=ChickWeight[ChickWeight$Diet == 1,])
    model2 <- lm(weight ~ Time, data=ChickWeight[ChickWeight$Diet == 2,])
    model3 <- lm(weight ~ Time, data=ChickWeight[ChickWeight$Diet == 3,])
    model4 <- lm(weight ~ Time, data=ChickWeight[ChickWeight$Diet == 4,])
    
    modelAllpred <- reactive({
        timeInput <- input$sliderTime
        predict(modelAll, newdata=data.frame(Time = timeInput))
    })
    model1pred <- reactive({
        timeInput <- input$sliderTime
        predict(model1, newdata=data.frame(Time = timeInput))
    })
    model2pred <- reactive({
        timeInput <- input$sliderTime
        predict(model2, newdata=data.frame(Time = timeInput))
    })
    model3pred <- reactive({
        timeInput <- input$sliderTime
        predict(model3, newdata=data.frame(Time = timeInput))
    })
    model4pred <- reactive({
        timeInput <- input$sliderTime
        predict(model4, newdata=data.frame(Time = timeInput))
    })
    
    output$plot <- renderPlot({
        timeInput <- input$sliderTime
        plot(weight ~ Time, data = ChickWeight, type = "n", 
             xlab = "Days since birth", ylab = "Weight (gm)")
        if (input$showDiet) {
            points(weight ~ Time, data = ChickWeight, col = Diet)
            abline(model1, col = "black", lwd = 2)
            points(timeInput, model1pred(), col="black", pch = 16, cex = 2)
            abline(model2, col = "red", lwd = 2)
            points(timeInput, model2pred(), col="red", pch = 16, cex = 2)
            abline(model3, col = "green", lwd = 2)
            points(timeInput, model3pred(), col="green", pch = 16, cex = 2)
            abline(model4, col = "blue", lwd = 2)
            points(timeInput, model4pred(), col="blue", pch = 16, cex = 2)
            legend("topleft", c("Diet 1 prediction", "Diet 2 prediction", 
                                "Diet 3 prediction", "Diet 4 prediction"), 
                   pch = c(16,16,16,16), col = c("black","red","green","blue"), 
                   cex = 1.2)
        }
        else {
            points(weight ~ Time, data = ChickWeight, col = "blue")
            abline(modelAll, col = "blue", lwd = 2)
            legend("topleft", c("All Diet prediction"), pch = c(16), 
                   col = "blue", cex = 1.2)
            points(timeInput, modelAllpred(), col = "blue", pch = 16, cex = 2)
        }
    })
    output$pred <- renderText({
        if (input$showDiet) {
            paste(" Diet 1:", model1pred(), "(gm)", "\n",
                  "Diet 2:", model2pred(), "(gm)", "\n",
                  "Diet 3:", model3pred(), "(gm)", "\n",
                  "Diet 4:", model4pred(), "(gm)", "\n")
        }
        else paste(" All Diet:", modelAllpred(), "(gm)")
    })
})
