library(ggplot2)
library(gganimate)

anim <- ggplot(mtcars, aes(mpg, disp)) +
  geom_point(aes(color = gear)) +
  transition_states(gear, transition_length = 2, state_length = 1) +
  enter_fade() +
  exit_fade() +
  labs(title = "MPG vs Disp Based on Gear", x = "MPG", y = "Disp")

anim <- animate(anim, height = 2, width = 3, 
                units = "in", res = 150, 
                fps = 8, end_pause = 20)
anim_save("mtcars_anim.gif", anim)

#}
# ## Animate
# - takes a gganim object and renders it into an animation
# - gives the ability to customize the animated plot
# - takes arguments like fps, duration, ref_frame, start_pause, end_pause and rewind
# 
# Let's look at an example!

# druggies <- readr::read_csv("./drugs.csv")
# 
# d <- druggies %>%
#   filter('State' %in% c("Oregon", "Wisconsin", "Illinois"))
# 
# d <- d %>%
#   ggplot(mapping = aes(x = Year, 
#                        y = `Rates.Marijuana.New Users.12-17`,
#                        color = State)) +
#   geom_point()
# 
# d.animation <- d +
#   transition_time(Year) + 
#   labs(title = "New Teen Marijuana Users", subtitle = "Year: transition_time(as.integer(year))", x = 'Year') +
#   shadow_trail(distance = 0.01)


#animate(d.animation, )