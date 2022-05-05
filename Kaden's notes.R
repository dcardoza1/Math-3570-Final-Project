library(gifski)
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
  shadow_trail()
d.animation



# +
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

