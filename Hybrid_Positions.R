# --- Clustering Hybrid Offensive Players ---

# Step 1: Select features and run clustering
sample_data <- subset(players_A, select = c(ast_100, ast_percentage, oreb_100, fta_100))
cluster_data_A <- cmeans(sample_data, centers = 4, m = 2)

# Step 2: Assign cluster labels and membership scores
players_A$clusters <- as.numeric(cluster_data_A$cluster)
cluster_labels <- c("A", "B", "C", "D")
for (i in 1:4) {
  players_A[[cluster_labels[i]]] <- cluster_data_A$membership[, i]
}

# Step 3: Separate players by cluster
clustered_players <- lapply(1:4, function(k) subset(players_A, clusters == k))
names(clustered_players) <- cluster_labels

# Step 4: Prepare numeric data without metadata columns
numerical_all_A_players <- subset(players_A, select = -c(...1, player, season, team, id))

# Step 5: Separate numeric data by cluster
numerical_by_cluster <- lapply(1:4, function(k) {
  subset(numerical_all_A_players, players_A$clusters == k)
})

# Step 6: Compute column-wise means for each cluster
averages_list <- lapply(numerical_by_cluster, colMeans)

# Step 7: Create and populate the summary DataFrame
averages <- do.call(rbind, averages_list)
rownames(averages) <- cluster_labels

# Step 8: Compute average ranks across clusters
avg_ranks <- as.data.frame(apply(averages, 2, function(col) rank(-col)))
rownames(avg_ranks) <- cluster_labels
