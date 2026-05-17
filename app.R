# library(shiny)
# 
# ui <- fluidPage(
#   titlePanel("Test textInput"),
#   sidebarLayout(
#     sidebarPanel(
#       h4("Enter the personal information"),
#       textInput("name", "Enter your name:"),
#       textInput("age", "Enter your age:")
#     ),
#     mainPanel(
#       h3('Personal information'),
#       textOutput("nameout"),
#       textOutput('ageout')
#     )
#   )
# )
# 
# server <- function(input, output) {
#   output$nameout <- renderText(input$name)
#   output$ageout <- renderText(input$age)
# }
# 
# shinyApp(ui = ui, server = server)
# 
# 
# ui <- fluidPage(
#   titlePanel("uiOutput Example"),
#   radioButtons("inputType", "Choose input type:",
#                choices = c("Text", "Number")),
#   uiOutput("dynamicInput"),
#   textOutput("valueout")
# )
# 
# server <- function(input, output) {
#   output$dynamicInput <- renderUI({
#     if (input$inputType == "Text") {
#       textInput("myinput", "Enter text:")
#     } else {
#       numericInput("myinput", "Enter number:", value = 0)
#     }
#   })
#   
#   output$valueout <- renderText({
#     paste("You entered:", input$myinput)
#   })
# }
# 
# shinyApp(ui = ui, server = server)

library(shiny)

ui <- fluidPage(
  titlePanel("Click on the Plot"),
  plotOutput("myplot", click = "plot_click"),
  verbatimTextOutput("clickinfo")
)

server <- function(input, output) {
  output$myplot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg,
         col = "steelblue", pch = 19,
         xlab = "Weight", ylab = "MPG",
         main = "Click anywhere on the plot")
  })
  
  output$clickinfo <- renderPrint({
    req(input$plot_click)
    cat("x =", round(input$plot_click$x, 2),
        " y =", round(input$plot_click$y, 2))
  })
}

shinyApp(ui = ui, server = server)