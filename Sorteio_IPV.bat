#install.packages("magick")
#install.packages("cowplot")

library(magick)
library(cowplot)
library(ggplot2)
library(rstudioapi)


get_wd_here <- readRDS("get_wd_here.rds")
ipv <- image_read(paste0(get_wd_here(),"/ipv.jpg"))

grDevices::x11()

Sys.sleep(5)

t = seq(0.9, 0.05, -0.09)^2

ggdraw()
for (i in t) {
  
  c("Liz Vallent", "Pedro Paulo", "Lênia", "Jonny") |>
    sample(1) -> s_name
  ggdraw() +
    draw_image(ipv,  x = 0., y = 0, scale = .9) +
    geom_label(aes(x = 0.5, y = 0.1, label = s_name), 
               size = 12,
               color = "black") -> p
  plot(p)
  Sys.sleep(i)
  if (i > min(t)) {
    ggdraw() |> plot()
  }
}

dev.off()
