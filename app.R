# Package setup ---------------------------------------------------------------

# Install required packages:
# install.packages("pak")
# pak::pak('surveydown-dev/surveydown') # Development version from github

# Load packages
library(surveydown)

# Database setup --------------------------------------------------------------
#
# Details at: https://surveydown.org/docs/storing-data
#
# surveydown stores data on any PostgreSQL database. We recommend
# https://supabase.com/ for a free and easy to use service.
#
# Once you have your database ready, run the following function to store your
# database configuration parameters in a local .env file:
#
# sd_db_config()
#
# Once your parameters are stored, you are ready to connect to your database.
# For this demo, we set ignore = TRUE in the following code, which will ignore
# the connection settings and won't attempt to connect to the database. This is
# helpful if you don't want to record testing data in the database table while
# doing local testing. Once you're ready to collect survey responses, set
# ignore = FALSE or just delete this argument.

db <- sd_db_connect(ignore = TRUE)

# UI setup --------------------------------------------------------------------

ui <- sd_ui()

# Server setup ----------------------------------------------------------------

server <- function(input, output, session) {

  # Define any conditional skip logic here (skip to page if a condition is true)
  sd_skip_forward()

  # Define any conditional display logic here (show a question if a condition is true)
  sd_show_if(
    !is.null(input$engage2) && isTRUE(any(tolower(input$engage2) == "other")) ~ "engage2_other", 
    !is.null(input$engage3) && isTRUE(any(tolower(input$engage3) == "other")) ~ "engage3_other",
    !is.null(input$top1) && isTRUE(any(tolower(input$top1) == "other")) ~ "top1_other",
    !is.null(input$top2) && isTRUE(any(tolower(input$top2) == "other")) ~ "top2_other",
    !is.null(input$top3) && isTRUE(any(tolower(input$top3) == "other")) ~ "top3_other",
    !is.null(input$contribute2) && isTRUE(any(tolower(input$contribute2) == "other")) ~ "contribute2_other",
    !is.null(input$structure3) && isTRUE(any(tolower(input$structure3) == "other")) ~ "structure3_other",
    !is.null(input$structure4) && isTRUE(any(tolower(input$structure4) == "other")) ~ "structure4_other",
    !is.null(input$demo3) && isTRUE(any(tolower(input$demo3) == "other")) ~ "demo3_other"
  )
  
  # Database designation and other settings
  sd_server(
    db = db
  )

}

# Launch the app
shiny::shinyApp(ui = ui, server = server)
