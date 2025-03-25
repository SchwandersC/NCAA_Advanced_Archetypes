# 🏀 NCAA Men's D1 2022–23 Offensive Archetypes

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

## 📊 Archetypes

| Main Role | Sub-Archetypes                                |
|-----------|-----------------------------------------------|
| Hybrid    | All Around, Three-Level Scorer, Off Ball Wing, In-and-Out Facilitator |
| Perimeter | Spot-Up Shooter, Stretch Shooter, Playmaker, Perimeter Scorer         |
| Interior  | Rim Roller, Slasher, Rebounder, Interior Facilitator                  |

---

## 📈 Output Example

Each player receives:
- A primary cluster label (`clusters`)
- Membership weights for `Hybrid`, `Perimeter`, `Interior`
- Sub-archetype scores per role (e.g., `three_level_scorer`, `rim_roller`)

---

## 📬 Questions?

Feel free to open an issue or contact [your GitHub username] for more info.