library(shiny)
#library(data.table)

#Training set 

train.set <-read.csv("training.csv", header=TRUE)
train.set <-train.set[,-1]

pageWithSidebar(
  
  #Page Header
  headerPanel('Medical Cost Predictor'),
  
  #input values
  sidebarPanel(
    HTML("<h3> Input Variables</h3>"),
    sliderInput("age", label="Age", value =23,
                 min= min(train.set$age),
                 max =max(train.set$age)
                
                ),
    sliderTextInput(inputId="smoker", label="Smoker", grid=TRUE, 
                    choices=c("yes", "no")),
    sliderInput("bmi", label="BMI", value= 26, 
                min = min(train.set$bmi),
                max =max(train.set$bmi)),
    sliderInput(("children"), label="Children", value= 1
                min=min(train.set$children),
                max=max(train.set$children)),
    sliderTextInput("region", label="Region", grid=TRUE,
                    choices=c("southwest", "northwest", "northeast", "southeast", "midwest", "mideast")),
    actionButton("submitbutton", "Submit", class="btn btn-primary")
  ),
  
  mainPanel(
    tags$label(h3('Status/Output')), #text box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') #prediction result
  )
)


