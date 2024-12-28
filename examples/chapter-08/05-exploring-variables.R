
# Getting variable information -----

all_vars <- fresh::search_vars_bs4dash()
nav_vars <- fresh::search_vars_bs4dash("navbar")


# Transforming to data.table -----

data.table::setDT(all_vars)
data.table::setDT(nav_vars)


# 1. Most of the variables comes from bootstrap ----

all_vars[, .N, source]


# 2. 19 bootstrap variables related to navbar

nav_vars[, .N, source]


# 3. Distribution of variables ----

nav_vars[, .N,
         .(is_dark = grepl("dark", variable),
           is_light = grepl("light", variable))]


# 4. Light/Dark independent ----

nav_vars[!grepl("light|dark", variable),
         !c("source")] |>
  tibble::as_tibble()


# 5. Listing light variables

nav_vars[grepl("light", variable),
         !c("source")] |>
  tibble::as_tibble()

