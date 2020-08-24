## Vincent Major
## August 2020

## run:
# > setwd('/work')
# > install.packages('packrat')
# > packrat::restore('/work')
# and then proceed

.libPaths()
packrat::on("/work")
.libPaths()


library(ggplot2)
library(dplyr)

## simple ggplot from gapminder data for example
gapminder = gapminder::gapminder

gapminder %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x = lifeExp, y = gdpPercap, 
             color = continent, size = pop)) +
  geom_point()

gapminder %>% 
  filter(year == 1957 | year == 2007) %>% 
  arrange(year) %>% 
  group_by(country) %>% 
  mutate(`% Difference in GDP per capita` = (gdpPercap - lag(gdpPercap))*100/lag(gdpPercap),
         `% Difference in Population` = (pop - lag(pop))*100/lag(pop),
         `% Difference in Life Expectancy` = (lifeExp - lag(lifeExp))*100/lag(lifeExp) ) %>% 
  filter(year == 2007) %>% 
  ggplot(aes(x = `% Difference in Population`, 
             y = `% Difference in Life Expectancy`,
             color = continent, 
             size = `% Difference in GDP per capita` )) +
  geom_point()
  
