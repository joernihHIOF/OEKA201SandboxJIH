library(DiagrammeR)
library(rsvg)
library(DiagrammeRsvg)


# Create and save the diagram
mermaid("
graph LR
    A-->B
") %>%
  export_svg() %>%
  charToRaw() %>%
  rsvg::rsvg_png("mermaid_graph.png")

# In your Quarto document, use:
knitr::include_graphics("mermaid_graph.png")


Sys.setenv(DOWNLOAD_STATIC_LIBV8=1)
install.packages("V8")
