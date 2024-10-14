## code to prepare "march_madness_dataset" for the analysis goes here

library(tidyverse)

public_picks <- read_csv("data-raw/public_picks.csv")
ratings <- read_csv("data-raw/538Ratings.csv")
index <- read_csv("data-raw/Heat_Check_Tournament_Index.csv")
#march_madness_dataset <- read_csv("data-raw/index_picks.csv")

public_picks <- public_picks |>
  select(TEAMNO,FINALS)

index <- index |>
  rename(TEAMNO = `TEAM NO`)

index_picks <- index |>
  left_join(public_picks, by = "TEAMNO")


# Remove any extraneous characters (e.g., percentage signs, spaces)
index_picks$FINALS <- gsub("%", "", index_picks$FINALS)  # Remove percentage signs
index_picks$FINALS <- gsub(" ", "", index_picks$FINALS)  # Remove spaces


# Convert FINALS to numeric
index_picks$FINALS <- as.numeric(index_picks$FINALS)

#Select variable
march_madness_dataset <- index_picks |>
  select(YEAR,TEAMNO,TEAM,SEED,ROUND,POWER,FINALS) |>
  filter(YEAR >= 2016)
