## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE
)
library(sigmajs)

## ------------------------------------------------------------------------
nodes <- sg_make_nodes() 
edges <- sg_make_edges(nodes)

sigmajs() %>% 
  sg_nodes(nodes, id, size, color) %>% 
  sg_edges(edges, id, source, target) %>% 
  sg_layout() %>% 
  sg_export_svg() %>% 
  sg_button(
    "<i class='fa fa-download'></i>", 
    "export_svg", # event to trigger
    class = "btn btn-default"
  )

## ------------------------------------------------------------------------
sigmajs() %>% 
  sg_nodes(nodes, id, size, color) %>% 
  sg_edges(edges, id, source, target) %>% 
  sg_force_start() %>% 
  sg_force_stop(3000) %>% 
  sg_button(
    "<i class='fa fa-play'></i> Layout", # only use icon if document imports fontawesome
    c("force_start", "force_stop"), 
    class = "btn btn-success"
  )

