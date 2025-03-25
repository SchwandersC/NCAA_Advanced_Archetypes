library(e1071)

# --- Clustering Perimeter Offensive Players ---

# Step 1: Select features and run clustering
sample_data <- subset(players_B, select = c(oreb_100, ast_100, assisted_percentage, perim_rate))
cluster_data_B <- cmeans(sample_data, centers = 4, m = 2)

# Step 2: Assign cluster labels and membership probabilities
players_B$clusters <- as.numeric(cluster_data_B$cluster)
cluster_labels <- c("A", "B", "C", "D")
for (i in 1:4) {
  players_B[[cluster_labels[i]]] <- cluster_data_B$membership[, i]
}

# Step 3: Separate players by cluster (optional)
clustered_players <- lapply(1:4, function(k) subset(players_B, clusters == k))
names(clustered_players) <- cluster_labels

# Step 4: Remove metadata to get only numeric stats
numerical_all_B_players <- subset(players_B, select = -c(...1, player, season, team, id))

# Step 5: Split numeric data by cluster
numerical_by_cluster <- lapply(1:4, function(k) {
  subset(numerical_all_B_players, players_B$clusters == k)
})

# Step 6: Compute average stat profile for each cluster
averages_list <- lapply(numerical_by_cluster, colMeans)

# Step 7: Combine into a summary DataFrame
averages <- do.call(rbind, averages_list)
rownames(averages) <- cluster_labels

# Step 8: Calculate ranks per stat (higher = better)
avg_ranks <- as.data.frame(apply(averages, 2, function(col) rank(-col)))
rownames(avg_ranks) <- cluster_labels
