library(e1071)

# --- Clustering Interior Offensive Players ---

# Step 1: Select features and apply clustering
sample_data <- subset(players_C, select = c(oreb_100, ast_100, ast_percentage, assisted_percentage))
cluster_data_C <- cmeans(sample_data, centers = 4, m = 2)

# Step 2: Assign cluster labels and membership scores
players_C$clusters <- as.numeric(cluster_data_C$cluster)
cluster_labels <- c("A", "B", "C", "D")
for (i in 1:4) {
  players_C[[cluster_labels[i]]] <- cluster_data_C$membership[, i]
}

# Step 3: Separate players by cluster (if needed later)
clustered_players <- lapply(1:4, function(k) subset(players_C, clusters == k))
names(clustered_players) <- cluster_labels

# Step 4: Prepare numeric data (remove metadata)
numerical_all_C_players <- subset(players_C, select = -c(...1, player, season, team, id))

# Step 5: Split numeric data by cluster
numerical_by_cluster <- lapply(1:4, function(k) {
  subset(numerical_all_C_players, players_C$clusters == k)
})

# Step 6: Compute column-wise means per cluster
averages_list <- lapply(numerical_by_cluster, colMeans)

# Step 7: Assemble into a summary DataFrame
averages <- do.call(rbind, averages_list)
rownames(averages) <- cluster_labels

# Step 8: Compute average rankings
avg_ranks <- as.data.frame(apply(averages, 2, function(col) rank(-col)))
rownames(avg_ranks) <- cluster_labels
