# load ----
library(tidyverse)
read.csv('./data/SMA_inter.csv') -> dat

# Select, Filter, Sum, Join ----

dat %>% 
  group_by (AREANAME) %>% summarise(
    UnitTot = sum(sqMi_calc, na.rm = T)) -> tot
  
dat %>% 
  group_by (AREANAME,ADMIN_UN_1) %>% summarise(
    total = sum(sqMi_calc, na.rm = T)) %>%
    left_join(tot) %>%  
    mutate(percent = round(100*total/UnitTot,2)) -> out

# Write ----
out %>% write.csv('./out/AreaBySMAandUnit_sqmi.csv', row.names = F)