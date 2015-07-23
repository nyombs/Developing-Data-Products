library(shiny) 
shinyUI(
  navbarPage("",
    tabPanel("Content",
             pageWithSidebar( 
               titlePanel(" Can you financially afford an Ivy league education for your child?"),
               sidebarPanel(
                 p("Today, an Ivy League education is worth $50,000 a year in tuitions. Can you afford it once your child is ready for college?"),
                 p("Use the variables to see where you stack!"),
                 h4('College affordability variables'),
                 numericInput('sum', 'Amount saved today ($)', 50000, min = 10000, max = 100000000, step = 5000),
                 numericInput('years', "Number of years until my child start school", 5, min = 1, max = 30, step = 1),
                 h5('College Increase every year'),
                 sliderInput('tuitionRate', 'Yearly College Tuition Increase %', value = 1, min = 0.5, max = 5, step = 0.1),
                 h4('Rates impacting your savings'),
                 sliderInput('inflation', 'Inflation in %', value = 3, min = 2.4, max = 5, step = 0.1),
                 sliderInput('investRet', 'Investment return in %', value = 6, min = 4, max = 15, step = 0.5)
               ),
               mainPanel( 
                 h4("To afford 1 year of College you will need to have in today's money: ($)"),
                 textOutput("value"),
                 h4("Current Savings/Investment Yield in today's money ($)"), 
                 textOutput("investYield"), 
                 plotOutput('collegeCostPlot'),
                 br(),
                 plotOutput('investPlot'),
                 br()
               )
             )
      ),
      tabPanel("Help",
               mainPanel( 
                  h2("Documentation for calculating whether you have saved enough for yearly College tuition"),
                  br(),
                  p("This application does basic computation to figure out whether a given parent or potential parent is financially ready to afford an Ivy League education. For simplicity, it focuses on the yearly tution amount over time and see whether there will be sufficient funds after taking inflation and rate of return of investments into account." )
                  ,
                  h3("Inputs"),
                  p("Savings/Investment = money currently invested today."),
                  p("Years = number of years before the child starts college."),
                  p("Inflation = percentage on inflation per year, in a slider form. The value is used to calculate the decrease of value per year"),
                  p("College Tution Increase Rate = this value maps to the college tuition yearly increase. The value is used to calculate the increase cost of college's tution over time as a percentage."),
                  p("Investment Rate = percentage on investment return per year, in a slider form. The value is used to calculate the added value due to financial investment gains / losses per year"),
                  h3("Outputs"),
                  p("Value= Cost of College's 1 year tuition in today's money"),
                  p("Investment yield = Current Savings/Investment Yield in today's money.")
              )
      ) 
  )
)
