package.check <- function(packages) {
  for (x in packages) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
    }
  }
}

packages <- c("tidyverse", "magick", "cowplot")

package.check(packages)

library("ggplot2")

ipv <- magick::image_read(paste0(getwd(),"/ipv.jpg"))

nomes <- unique(read.csv(paste0(getwd(),"/df.txt"))[[1]])
nomes <- sub(" +$", "", nomes)
t = seq(0.9, 0.05, -0.09)^2

grDevices::x11()
cowplot::ggdraw()
Sys.sleep(5)

for (i in t) {
  
  nomes |>
    sample(1) -> s_name
  cowplot::ggdraw() +
    cowplot::draw_image(ipv,  x = 0., y = 0, scale = .9) +
    geom_label(aes(x = 0.5, y = 0.12, label = s_name), 
               size = 10,
               color = "black", 
               label.padding = unit(1.5, "lines"),
               label.r = unit(0.55, "lines"),
               label.size = 1) -> p
  
  plot(p)
  Sys.sleep(i)
  if (i > min(t)) {
    cowplot::ggdraw() |> plot()
  }
}

Sys.sleep(5)


