library(e1071)

# --- Step 1: Prepare data ---
player_data <- mens_d1_22_23

# Compute perimeter rate: % of shots taken from mid + three vs. total
player_data$perim_rate <- with(player_data, (mid_rate + three_rate) / (mid_rate + three_rate + rim_rate))
player_data[is.na(player_data)] <- 0

# --- Step 2: Clustering based on perimeter rate ---
sample_data <- subset(player_data, select = c(perim_rate))
cluster_data <- cmeans(sample_data, centers = 3, m = 2)

# Assign clusters and membership scores
player_data$clusters <- as.numeric(cluster_data$cluster)
cluster_labels <- c("A", "B", "C")
for (i in 1:3) {
  player_data[[cluster_labels[i]]] <- cluster_data$membership[, i]
}

# --- Step 3: Optional – Split by cluster if needed later ---
players_by_cluster <- lapply(1:3, function(k) subset(player_data, clusters == k))
names(players_by_cluster) <- cluster_labels

# --- Step 4: Analyze cluster profiles ---
numerical_all_players <- subset(player_data, select = -c(...1, player, season, team, id))

# Split numeric stats by cluster
numerical_by_cluster <- lapply(1:3, function(k) {
  subset(numerical_all_players, player_data$clusters == k)
})

# Compute average stats per cluster
averages_list <- lapply(numerical_by_cluster, colMeans)
averages <- do.call(rbind, averages_list)
rownames(averages) <- c("Hybrid", "Perimeter", "Interior")  # based on analysis

# --- Step 5: Compute rankings of each stat across clusters ---
avg_ranks <- as.data.frame(apply(averages, 2, function(col) rank(-col)))
rownames(avg_ranks) <- rownames(averages)

# --- Step 6: Save cluster centers for reuse ---
cluster_centers <- cluster_data$centers  # save this to apply to new data later
