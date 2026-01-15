# Load required libraries
library(readr)
library(dplyr)
library(ggplot2)
library(readxl)
library(tidyr)
library(ggforce) # For donut chart

# Load datasets
milw <- read_csv("KiaHyundaiMilwaukeeData.csv")
thefts <- read_csv("kiaHyundaiThefts.csv")
map <- read_csv("carTheftsMap.csv")
vice <- read_excel("Motherboard VICE News Kia Hyundai Theft Data.xlsx")

# Visual 1: Stacked Area Chart - National Average Thefts Over Time
nat_avg <- thefts %>% 
  group_by(year, month) %>% 
  summarise(KH = mean(countKiaHyundaiThefts), Other = mean(countOtherThefts)) %>% 
  pivot_longer(c(KH, Other), names_to = "Type", values_to = "Count")
ggplot(nat_avg, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = Count, fill = Type)) + 
  geom_area() + 
  theme_minimal() + 
  labs(title = "National Average Thefts Over Time", y = "Average Count") + 
  ggsave("visual1.png")

# Visual 2: Area Chart - Percent Kia/Hyundai Thefts in Milwaukee Over Time
ggplot(milw, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = percentKiaHyundai)) + 
  geom_area(fill = "blue") + 
  theme_minimal() + 
  labs(title = "Kia/Hyundai Theft % in Milwaukee", y = "%") + 
  ggsave("visual2.png")

# Visual 3: Pie Chart - 2022 Theft Breakdown by City
pie22 <- thefts %>% 
  filter(year == 2022) %>% 
  group_by(city) %>% 
  summarise(pct = mean(percentKiaHyundai))
ggplot(pie22, aes(x = "", y = pct, fill = city)) + 
  geom_bar(stat = "identity") + 
  coord_polar("y") + 
  theme_void() + 
  labs(title = "2022 Theft Share by City") + 
  ggsave("visual3.png")

# Visual 4: Donut Chart - Percent Change Categories (2019-2022)
chg_cat <- map %>% 
  mutate(cat = cut(percentChange2019to2022, 
                   breaks = c(-Inf, 0, 0.5, 1, Inf), 
                   labels = c("Decrease", "0-50% Increase", "50-100% Increase", ">100% Increase"))) %>% 
  count(cat)
ggplot(chg_cat, aes(x = 2, y = n, fill = cat)) + 
  geom_bar(stat = "identity") + 
  xlim(0.5, 2.5) + 
  coord_polar("y") + 
  theme_void() + 
  labs(title = "Percent Change Categories 2019-2022") + 
  ggsave("visual4.png")

# Visual 5: Bar Chart - Top Agencies by 2022 Kia/Hyundai Thefts
vice22 <- vice %>% 
  select(1, contains("2022")) %>% 
  filter(!is.na(`Kia/Hyundais 2022`)) %>% 
  slice(1:10) %>% 
  pivot_longer(cols = contains("Kia"), names_to = "Year", values_to = "Count")
ggplot(vice22, aes(x = `...1`, y = Count)) + 
  geom_bar(stat = "identity") + 
  theme_minimal() + 
  labs(title = "Top Agencies by 2022 Thefts") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels
  ggsave("visual5.png")

# Visual 6: Line Chart - Average Percent Kia/Hyundai Across Cities Over Time
avg_pct <- thefts %>% 
  group_by(year, month) %>% 
  summarise(avg_pct = mean(percentKiaHyundai))
ggplot(avg_pct, aes(x = as.Date(paste(year, month, "01", sep = "-")), y = avg_pct)) + 
  geom_line() + 
  theme_minimal() + 
  labs(title = "Average Kia/Hyundai % Across Cities") + 
  ggsave("visual6.png")
       
