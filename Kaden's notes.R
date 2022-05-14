# Package names
packages <- c("knitr", "gifski", "gganimate", "ggplot2", "graphics",
              "grDevices", "dplyr", "magrittr", "readr", "ggthemes", 
              "tidyverse", "transformr")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

library(gifski)
library(datasets)
library(gganimate)
library(ggplot2)
library(graphics)
library(grDevices)
library(dplyr)
library(magrittr)
library(readr)
library(ggthemes)

druggies <- readr::read_csv("./drugs.csv")

d <- druggies %>%
  filter(State %in% c("Oregon", "Wisconsin", "Illinois"))

d <- d %>%
  ggplot(mapping = aes(x = Year, 
                       y = `Rates.Marijuana.New Users.12-17`,
                       color = State)) +
  geom_point()
 
d.animation <- d +
  transition_time(Year)+
  labs(title = "PEE PEE? MORE LIKE POO POO", subtitle = "Year:  {frame_time}") + 
  shadow_wake(wake_length = 0.5)
#d.animation

#transition_reveal example
players <- read_csv("./Player Per Game.csv")

scorers <- players %>%
  filter(pts_per_game > 30)
scorers

scorers <- scorers %>%
  ggplot(mapping = aes(x = season, y = pts_per_game, color = player))+
  geom_point()+
  labs(title = "30+ PPG Scorers 1947-2021", y = "Points Per Game", x = "Season", color = "Player")+
  coord_cartesian(ylim = c(30, 40))+
  theme_hc()

scorers.animation <- scorers +
  transition_reveal(season)+
  shadow_wake(wake_length = 1.5)
#scorers.animation

#transition_layer example
cars <- mtcars %>%
  ggplot(mapping = aes(x = mpg, y = hp, color = cyl))+
  geom_point()


cars.animation <- cars +
  transition_filter(
    filter_length = 1.5,
    Efficient = mpg > 22,
    Powerful = disp > 250,
    Fast = qsec < 16,
    Automatic = am == 0,
    Manual = am == 1,
    wrap = FALSE
  )+
  ggtitle(
    'Filter: {closest_filter}',
    subtitle = '{closest_expression}')
    
#cars.animation

#Andrew Simon Transition states example
#Import data of BJT simulation (and remove unwanted columns) 
bjt_df <- readr::read_csv("./bjtData.csv")
bjt_df <- select(bjt_df, Ib_mA, Vce_V, Ic_A)

#bjt_df$Ib_mA %<>% as.character
bjt_df

#Create ggplot of data
bjt_plt <- bjt_df %>%
  ggplot(mapping = aes(x = Vce_V, 
                       y = Ic_A,
                       color = Ib_mA)) +
  geom_line() +
  theme(legend.position = "none") +
  labs(x = "Voltage Vce (V)",
       y = "Current Ic (A)")
#bjt_plt

#Apply transition time animation to show change in output according to base current
#bjt_animplt <- bjt_plt +
#                     transition_time(Ib_mA) +
#                     labs(title = "I-V Characteristics of BJT Component",
#                          subtitle = "Base Current Ib = {frame_time} mA") +
#                     shadow_mark(alpha = 0.5)

#Apply transition state animation to show change in output according to base current
bjt_animplt <- bjt_plt +
  transition_states(Ib_mA,
                    transition_length = 0.25,
                    state_length = 1,
                    wrap = FALSE) +
  labs(title = "I-V Characteristics of BJT Component",
       subtitle = "Base Current Ib = {closest_state} mA") +
  shadow_mark(alpha = 0.5)

#Show the animation
#bjt_animplt

#anim_save("bjtplot.gif", bjt_animplt)

 #+
#   geom_point() + 
#   geom_line() + 
#   geom_line(aes(y = Rates))

#x <- ggplotly(d)

# anim <- d + 
#   transition_time(d$Year, range = c())
# an

# GGPlot extension: Animate

# • Introduce package, arguments
# • show example of when you'd wanna use it
# 	• generate examples of animated graphs
# 
# it's a good idea to keep your base graph in a separate object from your animated graph so you can adjust shit without loading for 12 years
# 
# Basic graph:
#   1. create a ggplot object
# 2. Add a transition layer to the ggplot (such as transition_time())
#   a. insert the column name of the variable you want to transition by (ie Year)
# 3. Add labs()
#   a. you can use the variable {frame_time} which the package creates
# 4. Add trails with shadow_wake()
#   a. in the (), set wake_length // 1 = 100% of the frames
# 5. Pass it into the animate() function
#   a. in this function, set height and width by number of pixels
#   b. set fps, duration, endpause (in number of frames)
#   c. set res- short for resolution, affects size of points
# 
# Gradually revealing graph:
#   use transition_reveal
# can add view_follow for the view to adjust as well, 
# defaults x and y moving, set fixed_x or fixed_y to False to fix dis

