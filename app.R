library(shiny)
library(dplyr)

pizza_poll <- as_tibble(jsonlite::fromJSON("https://www.jaredlander.com/data/PizzaPollData.php"))

# clean up the data little bit
pizza_poll <- pizza_poll %>%
  janitor::clean_names() %>%
  mutate(
    time = lubridate::as_datetime(time),
    date = lubridate::as_date(time),
    answer = forcats::as_factor(answer)
  ) %>%
  select(-time, -question, -percent, -pollq_id, -total_votes) %>%
  rename(poll_id = polla_qid)

ui <- fluidPage(
  verbatimTextOutput("debug"),
  a("Pizza Poll", href = "http://bit.ly/pizzapoll")
)

server <- function(input, output, session) {
  output$debug <- renderPrint({
    glimpse(pizza_poll)
  })
}

shinyApp(ui, server)
