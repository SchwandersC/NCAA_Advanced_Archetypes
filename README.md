# 🏀 NCAA Men's D1 Offensive Archetypes

This repository analyzes player-level offensive tendencies in NCAA Men’s Division 1 basketball (2022–2023 season) and clusters players into interpretable archetypes: **Hybrid**, **Perimeter**, and **Interior**.

The project uses fuzzy clustering (via `e1071::cmeans`) to assign soft membership across offensive styles and subroles (e.g. *three-level scorer*, *rim roller*, etc.).

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

## 🤖 Why Fuzzy Clustering?
Traditional clustering methods (like K-Means) force players into a single archetype, which often oversimplifies their real on-court roles. In contrast, this project uses Fuzzy C-Means Clustering (e1071::cmeans) to assign players membership scores across multiple archetypes.

This approach acknowledges that players often blend styles—for example, a forward may function as both a rim roller and a rebounder, or a guard may mix spot-up shooting with perimeter playmaking.

By applying fuzzy clustering at both the macro (Hybrid/Perimeter/Interior) and micro (sub-archetypes) levels, we’re able to:

Capture nuanced player tendencies
Reflect hybridization in modern basketball roles
Enable better player comparison and profiling
Support downstream tasks like scouting, lineup building, and transfer evaluations

---

## 🧬 Archetype Definitions

| **Main Role** | **Sub-Archetype**         | **Description** |
|---------------|---------------------------|-----------------|
| **Hybrid**    | **All Around**            | Balanced contributors across scoring and playmaking zones; capable of finishing at the rim, shooting from distance, and facilitating. |
|               | **Three-Level Scorer**    | Proficient at scoring from mid-range, beyond the arc, and at the rim; offensively versatile and hard to contain. |
|               | **Off Ball Wing**         | Moves well without the ball, cuts into space, and scores efficiently when set up by others; thrives within flow offenses. |
|               | **In-and-Out Facilitator**| Switches between interior and perimeter zones while initiating offense; blends court vision with scoring pressure. |
| **Perimeter** | **Spot-Up Shooter**       | Excels at catch-and-shoot opportunities from the perimeter; often spaces the floor and capitalizes on kick-outs. |
|               | **Stretch Shooter**       | Bigs or forwards who can shoot from deep, pulling defenders out of the paint and opening driving lanes. |
|               | **Playmaker**             | Initiates offense from the outside, creating scoring chances for teammates through passing and decision-making. |
|               | **Perimeter Scorer**      | Aggressive offensive player focused on shot creation and scoring from the mid-range and three-point line. |
| **Interior**  | **Rim Roller**            | Strong finisher on pick-and-rolls and cuts to the basket; thrives near the rim off movement and lobs. |
|               | **Slasher**               | Creates offense by attacking the basket off the dribble or cuts; generates high-pressure rim attempts. |
|               | **Rebounder**             | Specializes in securing offensive and defensive boards, often providing second-chance opportunities. |
|               | **Interior Facilitator**  | Connects plays from the post or high elbow; uses vision and touch to set up teammates from inside. |

---

## 📌 Use Cases
This player archetyping system has a wide range of use cases for teams, analysts, and researchers:

🧩 Roster Construction: Identify complementary player types when building lineups or targeting transfers. Blend roles (e.g. stretch shooter + slasher) to optimize spacing and balance.

🔄 Transfer Portal Scouting: Quickly assess how a potential recruit fits into your system by comparing their archetype scores with current or past players.

📈 Player Development: Track how a player’s tendencies evolve across seasons (e.g., increasing perimeter playmaking or shifting toward interior roles).

🎯 Game Planning: Prepare for opponents by profiling their top players’ offensive tendencies—e.g., knowing a player is both a perimeter scorer and off-ball wing helps with matchup assignments.

📊 Research & Media: Provide advanced context beyond box scores when comparing players or writing scouting reports.

Because this system uses fuzzy clustering, players aren't limited to a single label—making it better suited to modern, positionless basketball and hybrid roles.

## 📈 Output Example

[View Example Notebook](./ExampleNotebook.ipynb)

---

## 📬 Questions?

Feel free to open an issue or contact [SchwandersC] for more info.
