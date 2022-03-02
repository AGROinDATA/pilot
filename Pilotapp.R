#This is the Pilot Shiny app of Agro in Data

library(shiny)
library(shinydashboard)
library(DT)

###########################################
#DATA input

library(readxl)
 
Agroindata <- read_excel("C:/Users/zorro/Documents/Consultant business/Agro in Data/example dataset/1E excel.xls")

Agroindata$agricultor<-as.factor(Agroindata$agricultor) 
Agroindata$variedad<-as.factor(Agroindata$variedad) 
Agroindata$comuna<-as.factor(Agroindata$comuna) 
Agroindata$zonal<-as.factor(Agroindata$zonal)

library(lubridate)
Agroindata$`fecha cosecha`<-ymd(Agroindata$`fecha cosecha`)


# Define UI for application 
###########################################
ui <- dashboardPage ( skin = "green",
  dashboardHeader(title = "AGRO in DATA"  ),
  dashboardSidebar(
    sidebarMenu(
    menuItem("Kilos", tabName = "kilos", icon = icon("tree")),
    menuItem("Datos", tabName = "datos", icon = icon("database")))),
  

dashboardBody(
    valueBox(4, "Total de variedades"),
    valueBox(100, "Numero de datos"),
    valueBox(5, "N° Zonales"),
    
    tabItems(
      tabItem("kilos",
              box(plotOutput("correlationplot"), width = 8),
              box(
      selectInput("opciones", "Opciones",
                  c("kg", "ha",
                    "años de experiencia")), width = 4
    ) ),
    tabItem("datos",
            fluidPage(h1("Fuente de datos"),
                      dataTableOutput("agroindatatable"))
            ))))


#########################################
server <- function(input, output) {
  output$correlationplot <- renderPlot({
    #options(scipen = 9)
    plot(Agroindata$kg, Agroindata[[input$opciones]],
         xlab= "Kilos", ylab = "Opciones", title("Grafico Kilos vs Opciones"))}
    )
  output$agroindatatable <- renderDataTable(Agroindata)
}

#########################################
shinyApp(ui, server)
