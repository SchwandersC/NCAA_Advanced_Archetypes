# 🏀 NCAA Men's D1 Offensive Archetypes

This repository analyzes player-level offensive tendencies in NCAA Men’s Division 1 basketball (2022–2023 season) and clusters players into interpretable archetypes: **Hybrid**, **Perimeter**, and **Interior**.

The project uses fuzzy clustering (via `e1071::cmeans`) to assign soft membership across offensive styles and subroles (e.g. *three-level scorer*, *rim roller*, etc.).

---

## 📁 Project Structure

```
.
├── data/
│   └── mens_d1_22_23_clusters_revised2.csv     # Cleaned player data with cluster memberships
│
├── Archetype Data Cleaning (1).ipynb           # Raw cleaning and prep (Jupyter Notebook)
├── Main_Clusters.R                             # Main Hybrid/Perimeter/Interior clustering
├── Hybrid_Positions.R                          # Sub-archetypes for Hybrid offensive players
├── Perimeter_Positions.R                       # Sub-archetypes for Perimeter offensive players
├── Interior_Positions.R                        # Sub-archetypes for Interior offensive players
├── New_Player_Archetypes.R                     # Applies saved cluster centers to new players
├── README.md                                   # You're here!
```

---

## 🚀 Getting Started

### 🔧 Requirements

- R (>= 4.0)
- Packages:
  - `e1071` – fuzzy clustering
  - `dplyr`, `tidyverse` – (optional for cleaning/analysis)
  - `readr`, `data.table` – (optional for I/O)

Install with:

```r
install.packages("e1071")
```

---

## 🔍 Workflow Overview

1. **`Main_Clusters.R`**  
   Clusters all players into 3 high-level offensive roles:
   - Hybrid
   - Perimeter
   - Interior

2. **`Hybrid_Positions.R`, `Perimeter_Positions.R`, `Interior_Positions.R`**  
   For each main role, players are further clustered into 4 specific sub-archetypes using different feature sets.

3. **`New_Player_Archetypes.R`**  
   Allows you to apply the saved cluster centers to new incoming players (e.g., for the 2023–24 season).

4. **`data/mens_d1_22_23_clusters_revised2.csv`**  
   Final output containing all archetype assignments and membership weights.

---

🤖 Why Fuzzy Clustering?
Traditional clustering methods (like K-Means) force players into a single archetype, which often oversimplifies their real on-court roles. In contrast, this project uses Fuzzy C-Means Clustering (e1071::cmeans) to assign players membership scores across multiple archetypes.

This approach acknowledges that players often blend styles—for example, a forward may function as both a rim roller and a rebounder, or a guard may mix spot-up shooting with perimeter playmaking.

By applying fuzzy clustering at both the macro (Hybrid/Perimeter/Interior) and micro (sub-archetypes) levels, we’re able to:

Capture nuanced player tendencies
Reflect hybridization in modern basketball roles
Enable better player comparison and profiling
Support downstream tasks like scouting, lineup building, and transfer evaluations

---

## 📊 Archetypes

After much testing, these twelve emerged as the dominant archetypes.

| Main Role | Sub-Archetypes                                |
|-----------|-----------------------------------------------|
| Hybrid    | All Around, Three-Level Scorer, Off Ball Wing, In-and-Out Facilitator |
| Perimeter | Spot-Up Shooter, Stretch Shooter, Playmaker, Perimeter Scorer         |
| Interior  | Rim Roller, Slasher, Rebounder, Interior Facilitator                  |

---

## 📈 Output Example

[View Example Notebook](./ExampleNotebook.ipynb)

---

## 📬 Questions?

Feel free to open an issue or contact [SchwandersC] for more info.
