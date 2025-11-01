# Titanic Survivability Prediction (Python and R with Docker)

## Overview
This project develops logistic regression models in both Python and R to predict passenger survival on the Titanic. Each implementation is containerized using Docker to ensure reproducibility and portability. The instructions below explain how to download the data and run both containers step by step.

---

## Repository Structure
```
titanic-disaster/
│
├── data/                  # CSV files (download manually from Kaggle)
├── src/
│   ├── code/              # Python implementation
│   │   └── main.py
│   └── r/                 # R implementation
│       └── main.R
│
├── Dockerfile             # Python container configuration
├── Dockerfile_R           # R container configuration
├── requirements.txt       # Python dependencies
└── README.md              # Project documentation
```

---

## Step 1: Download the Data

Download the dataset from the official Kaggle Titanic competition page:

**URL:** https://www.kaggle.com/competitions/titanic/code

### Required Files
- train.csv
- test.csv
- gender_submission.csv

### Instructions
1. Visit the Kaggle link above and log in.
2. Click the **Data** tab and select **Download All**.
3. Extract the ZIP file.
4. Move the three CSV files into your local project directory under `titanic-disaster/data/`.

The final structure should look like this:
```
titanic-disaster/
└── data/
    ├── train.csv
    ├── test.csv
    └── gender_submission.csv
```

---

## Step 2: Run the Python Docker Container

### Build the Image
Run the following command from the project root directory:
```bash
docker build -t titanic-app .
```

### Execute the Container
```bash
docker run --rm -it titanic-app
```

### Output
The container will:
- Load and clean the training data
- Display data summaries and missing value statistics
- Train a logistic regression model
- Output model coefficients and intercepts
- Display training and test accuracy

All progress and results are printed directly in the terminal.

---

## Step 3: Run the R Docker Container

### Build the Image
From the project root directory:
```bash
docker build -t titanic-r -f Dockerfile_R .
```

### Execute the Container
```bash
docker run --rm -it -v "%cd%/data:/app/data" titanic-r
```

### Output
The R container will:
- Load and clean the Titanic dataset
- Display missing value summaries and cleaned data overview
- Train a logistic regression model using `glm`
- Display model coefficients and training accuracy
- Output test prediction summaries and test accuracy

---

## Notes
- The `data` directory is excluded from version control. You must download the CSV files manually before running the containers.
- Both containers access the same dataset through the mounted `/app/data` directory.
- Docker caching ensures efficient rebuilds as dependencies are reinstalled only when package files change.
