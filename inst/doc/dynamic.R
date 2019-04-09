## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
library(htmltools)
library(sigmajs)

## ------------------------------------------------------------------------
# generate data using convenience functions
nodes <- sg_make_nodes(50)
edges <- sg_make_edges(nodes)
edges$delay <- runif(15, 500, 750) # between .5 and .75 seconds between each edge

last_edge <- sum(edges$delay) + 100

sigmajs() %>%
  sg_force_start() %>%
  sg_nodes(nodes, id, size, color) %>%
  sg_add_edges(edges, delay, id, source, target, refresh = TRUE) %>% # read delay documentation
  sg_force_stop(last_edge) %>% 
  sg_button(
    "add_edges", # event
    class = "btn btn-primary", # button class
    tag = tags$a,
    "Add edges" # label
  )

## ------------------------------------------------------------------------
# adding random but ordered dates to edges
dates <- seq.Date(from = Sys.Date(), Sys.Date() + 24, "days")
dates <- sample(dates, nrow(edges), replace = TRUE)

edges$dates <- dates[order(dates)]

sigmajs() %>%
  sg_force_start() %>%
  sg_nodes(nodes, id, size, color) %>%
  sg_add_edges(edges, delay, id, source, target, refresh = TRUE) %>% # read delay documentation
  sg_progress(edges, delay, dates, class = "text-warning", position = "bottom") %>% # add progress text
  sg_force_stop(last_edge) %>% 
  sg_button(
    "add_edges", # event
    class = "btn btn-primary",
    tag = tags$a,
    "Add edges" # label
  )

## ------------------------------------------------------------------------
nodes <- sg_make_nodes(75)
nodes$batch <- c(
	rep(1000, 25),
	rep(3000, 25),
	rep(5000, 25)
)

edges <- data.frame(
	id = 1:120,
	source = c(
		sample(1:25, 40, replace = TRUE),
		sample(1:50, 40, replace = TRUE),
		sample(1:75, 40, replace = TRUE)
	),
	target = c(
		sample(1:25, 40, replace = TRUE),
		sample(1:50, 40, replace = TRUE),
		sample(1:75, 40, replace = TRUE)
	),
	batch = c(
		rep(1000, 40),
		rep(3000, 40),
		rep(5000, 40)
	)
) %>% 
	dplyr::mutate_all(as.character)

sigmajs() %>% 
	sg_force_start() %>% 
	sg_read_nodes(nodes, id, color, size, delay = batch) %>% 
	sg_read_edges(edges, id, source, target, delay = batch) %>% 
	sg_force_stop(6000) %>% 
	sg_read_exec() %>% 
	sg_button(
		c("read_exec", "force_stop"), 
		"Add nodes & edges",
    class = "btn btn-primary",
    tag = tags$a
	)

