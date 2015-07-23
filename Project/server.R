library(shiny) 
shinyServer( 
  function(input, output){ 
    output$value <- renderText({computeSavingNeededToday(input$sum, input$years, input$tuitionRate)})
    output$investYield <- renderText({ calculateInvestYield(input$sum, input$years, input$inflation, input$investRet) }) 
    
    computeSavingNeededToday <- function (sum, years, tuitionRate)  
    { 
      tuition = 0.01 * tuitionRate
      growSum <- sum  
      for (i in 1:years){
        growSum<-growSum + (growSum*tuition)
      }
      result <- growSum
      return(round(result, digits = 2)) 
    } 
    
    
    calculateInvestYield <- function (sum, years, inflat, investRet)  
    { 
      inflation = -0.01 * inflat
      investReturn = 0.01*investRet
      growSum <- sum    
      for (i in 1:years){
        growSum<-growSum + (growSum*investReturn)
        growSum <- growSum + (growSum*inflation)
      }
      result <- growSum
      return(round(result, digits = 2)) 
    }
    
    ## plot functions:
    
    output$collegeCostPlot<- renderPlot({
      cRate <- 0.01 * input$tuitionRate
      linePlace <- input$years
      growSum <- 50000 #CollegeTutionCost   
      cbData<-data.frame(1, 1)
      for (i in 1:50)
      {
        growSum<-growSum + (growSum*cRate)
        cbData[i, 1]<-as.numeric(round(growSum, digits = 2))
        cbData[i, 2] <- i
      }
      plot(cbData[, 2], cbData[, 1], xlab = "Years from now", ylab = "Sum", main = "Yearly College Tution over time (50K today)", col="blue", ylim = c(min(cbData[, 1]), max(cbData[,1]) ), type = "o")
      lines(cbData[, 2], cbData[, 1], type = "h", lwd=1.5, col = "red")
      lines(cbData[as.numeric(linePlace), 2], cbData[as.numeric(linePlace), 1], type = "h", lwd=5, col = "black") 
    })
    
    
    output$investPlot<- renderPlot({
      inflation = -0.01 * input$inflation
      iRate <- 0.01 * input$investRet
      linePlace <- input$years
      growSum <- input$sum   
      ciData<-data.frame(1, 1)
      for (i in 1:50)
      {
        growSum<-growSum + (growSum*iRate)
        growSum<-growSum + (growSum*inflation)
        ciData[i, 1]<-as.numeric(round(growSum, digits = 2))
        ciData[i, 2] <- i
      }
      plot(ciData[, 2], ciData[, 1], xlab = "Years from now", ylab = "Sum", main = "Return on Investment per year", col="blue", ylim = c(min(ciData[, 1]), max(ciData[,1]) ), type = "o")
      lines(ciData[, 2], ciData[, 1], type = "h", lwd=1.5, col = "red")
      lines(ciData[as.numeric(linePlace), 2], ciData[as.numeric(linePlace), 1], type = "h", lwd=5, col = "black")    })
    
    
  })