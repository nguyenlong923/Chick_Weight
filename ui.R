#
# This is the user-interface definition of a Shiny web application that 
# submitted for the final Assignment of the Developing Data Products course. 
# You can run the application by clicking 'Run App' above.
#


library(shiny)
data("ChickWeight")

shinyUI(fluidPage(
    titlePanel("Final Assignment - Long NH"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderTime", label="Days since birth",
                        min = min(ChickWeight$Time), max=max(ChickWeight$Time),
                        value = mean(ChickWeight$Time)),
            checkboxInput("showDiet", label="Show/Hide Diet"),
            submitButton("Execute !")
        ),
        mainPanel(
            tabsetPanel(type = "tab",
                        tabPanel("Supporting Documentation", br(), 
                                 verbatimTextOutput("out")),
                        tabPanel("Chick Weight Data", br(),
                                 plotOutput("plot"),
                                 verbatimTextOutput("pred")))
        )
    )    
))