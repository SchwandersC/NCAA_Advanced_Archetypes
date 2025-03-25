library(e1071)

# --- Step 1: Prepare data ---
p_data <- mens_d1_22_23
p_data$perim_rate <- with(p_data, (mid_rate + three_rate) / (mid_rate + three_rate + rim_rate))
p_data[is.na(p_data)] <- 0

# Use only `perim_rate` to assign main clusters (Hybrid / Perimeter / Interior)
sample_data <- subset(p_data, select = c(perim_rate))
main_clusters <- cmeans(sample_data, centers = cluster_data$centers, m = 2)

# Assign cluster labels and memberships
p_data$clusters <- as.numeric(main_clusters$cluster)
p_data$Hybrid    <- main_clusters$membership[, 1]
p_data$Perimeter <- main_clusters$membership[, 2]
p_data$Interior  <- main_clusters$membership[, 3]

# --- Step 2: Helper function to apply sub-clustering ---
apply_subclusters <- function(df, group_col, group_name) {
  # Hybrid clusters
  sample_A <- subset(df, select = c(ast_100, ast_percentage, oreb_100, fta_100))
  clusters_A <- cmeans(sample_A, centers = cluster_data_A$centers, m = 2)
  df$clusters_Hybrid <- as.numeric(clusters_A$cluster)
  df$all_around              <- clusters_A$membership[, 1] * df[[group_col]]
  df$three_level_scorer      <- clusters_A$membership[, 2] * df[[group_col]]
  df$off_ball_wing           <- clusters_A$membership[, 3] * df[[group_col]]
  df$in_and_out_facilitator  <- clusters_A$membership[, 4] * df[[group_col]]

  # Perimeter clusters
  sample_B <- subset(df, select = c(oreb_100, ast_100, assisted_percentage, perim_rate))
  clusters_B <- cmeans(sample_B, centers = cluster_data_B$centers, m = 2)
  df$clusters_perimeter      <- as.numeric(clusters_B$cluster)
  df$perimeter_scorer        <- clusters_B$membership[, 1] * df$Perimeter
  df$spotup_shooter          <- clusters_B$membership[, 2] * df$Perimeter
  df$perimeter_playmaker     <- clusters_B$membership[, 3] * df$Perimeter
  df$stretch_shooter         <- clusters_B$membership[, 4] * df$Perimeter

  # Interior clusters
  sample_C <- subset(df, select = c(oreb_100, ast_100, ast_percentage, assisted_percentage))
  clusters_C <- cmeans(sample_C, centers = cluster_data_C$centers, m = 2)
  df$clusters_interior       <- as.numeric(clusters_C$cluster)
  df$interior_facilitator    <- clusters_C$membership[, 1] * df$Interior
  df$rim_roller              <- clusters_C$membership[, 2] * df$Interior
  df$slasher                 <- clusters_C$membership[, 3] * df$Interior
  df$rebounder               <- clusters_C$membership[, 4] * df$Interior

  return(df)
}

# --- Step 3: Apply to each group ---
players_Hybrid    <- subset(p_data, clusters == 1)
players_Perimeter <- subset(p_data, clusters == 2)
players_Interior  <- subset(p_data, clusters == 3)

players_Hybrid    <- apply_subclusters(players_Hybrid, "Hybrid", "Hybrid")
players_Perimeter <- apply_subclusters(players_Perimeter, "Hybrid", "Perimeter")
players_Interior  <- apply_subclusters(players_Interior, "Hybrid", "Interior")

# --- Step 4: Combine & Export ---
p_data <- rbind(players_Interior, players_Hybrid, players_Perimeter)
write.csv(p_data, "womens_d1_22-23_clusters.csv", row.names = FALSE)
