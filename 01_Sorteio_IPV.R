library("ggplot2")

get_wd_here <- readRDS("get_wd_here.rds")
ipv <- magick::image_read(paste0(get_wd_here(),"/ipv.jpg"))

grDevices::x11()

nomes <- unique(read.csv("df.txt")$Nome)
t = seq(0.9, 0.05, -0.09)^2

cowplot::ggdraw()
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

dev.off()
