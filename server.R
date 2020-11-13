library(data.table)

model <- lm(charges ~ smoker + bmi + children + region, data = df)

shinyServer(function(input, output, session){
  #input data
  datasetInput <-reactive({
    df <- data.frame(
      Name= c("age",
              "children",
              "bmi",
              "smoker",
              "region"),
      Value = c(
                as.numeric(input$age),
                as.numeric(input$children),
                as.numeric(input$bmi),
                as.character(input$smoker),
                as.character(input$region)), stringsAsFactors = FALSE)
      
      charges <- 0
      df <- rbind(df, charges)
      input <-transpose(df)
      write.table(input, "input.csv", sep=",", quote =FALSE, row.names= FALSE, col.names= FALSE)
      
      test <- read.csv(paste("input", ".csv", sep =""), header =TRUE)
      
      Output <- data.frame(Prediction= predict(model, test))
      print(Output)
      
    
  })
  # status/output text box
  output$contents <-renderPrint({
    if (input$submitbutton>0){
      isolate("Calculation complete..")
    } else {
      return("server is ready for calculation")
    }
    
    
    
  })
  
  # prediction results table
  output$tabledata <-renderTable({
    if (input$submitbutton >0) {
      isloate(datasetInput())
    }
  })
})
