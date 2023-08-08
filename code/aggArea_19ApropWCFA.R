# load ----
library(tidyverse)
read.csv('./data/19aWcfaUnion_InterSMA.csv')  %>% mutate (AREANAME = Name) -> dat

dat %>%
  mutate(AREANAME = ifelse(AREANAME == '19A Proposed WCA', '19A Inside Prop WCA', AREANAME)) -> dat

# Select, Filter, Sum, Join ----

dat %>% 
  group_by (AREANAME) %>% summarise(
    areaTot = sum(sqMi_calc, na.rm = T)) -> tot

dat %>% 
  group_by (AREANAME,AGENCY_NAM) %>% summarise(
    sqMi = sum(sqMi_calc, na.rm = T)) %>%
  left_join(tot) %>%  
  mutate(percent = round(100*sqMi/areaTot,2)) %>% select(-areaTot) -> out
out

# Write ----
out %>% write.csv('./out/prop19Awcfa_areaBySMA.csv', row.names = F)

