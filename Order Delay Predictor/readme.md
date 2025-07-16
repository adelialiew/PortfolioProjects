# Order-Delay Predictor: Project Overview

---

## 1. Introduction
This document outlines the **Order-Delay Predictor** project, a streamlined initiative designed to forecast whether an order from the Olist marketplace will be delivered **late (1) or on time (0)**. The project serves as a practical demonstration of essential data science and analytics skills, including data wrangling, feature engineering, model training, evaluation, and the deployment of a simple interactive application using Streamlit.The dataset used in this project is from [Kaggle: Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

---

## 2. Quick-Start Guide
To set up and run the Order-Delay Predictor, follow the steps below. These commands will create a virtual environment, install dependencies, process the data, train the model, and launch the prediction interface.

1.  **Set up the Python Virtual Environment:**
    ```bash
    python -m venv .venv && source .venv/bin/activate
    ```

2.  **Install Project Dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Execute Data Preprocessing and Feature Engineering:**
    ```bash
    python -m src.feature_engineering
    ```
    This step processes the raw Olist datasets, merges them, engineers relevant features, and performs the train/test split.

4.  **Train and Evaluate the Prediction Model:**
    ```bash
    python -m src.train_model
    ```
    This command trains the Gradient Boosting Classifier on the processed data and outputs evaluation metrics, including a classification report and confusion matrix.

5.  **Launch the Streamlit Application:**
    ```bash
    streamlit run app/streamlit_app.py
    ```
    This will open a web-based interface in your browser, allowing for interactive predictions based on user-inputted order details.

---

## 3. Directory Layout
The project's structure is organized to ensure clarity and maintainability. Below is a detailed breakdown of the directories and their respective contents:
order_delay_predictor/
├── app/
│   └── streamlit_app.py        # Contains the source code for the Streamlit web application, enabling interactive prediction demonstrations.
│
├── src/                        # Core source code for data processing, modeling, and prediction logic.
│   ├── init.py             # Initializes the src package, facilitating shortcut imports for modules.
│   ├── config.py               # Centralized configuration file for defining paths, hyperparameters, and other global settings.
│   ├── data_loader.py          # Scripts responsible for loading raw Olist CSV datasets and merging them into a unified DataFrame.
│   ├── feature_engineering.py  # Implements the logic for creating new features from raw data and preparing the dataset for model training, including train/test splitting.
│   ├── train_model.py          # Handles the training of the order delay classification model and evaluates its performance.
│   └── predict.py              # Provides a helper function for making predictions using the trained model, designed for use by the Streamlit app or external modules.
│
├── data/                       # Stores the datasets used by the project.
│   └── raw/                    # Contains the raw, untransformed Olist marketplace CSV files.
│       ├── olist_customers_dataset.csv
│       ├── olist_order_reviews_dataset.csv
│       ├── olist_orders_dataset.csv
│       ├── olist_products_dataset.csv
│       ├── olist_sellers_dataset.csv
│       ├── olist_geolocation_dataset.csv
│       ├── olist_order_items_dataset.csv
│       ├── olist_order_payments_dataset.csv
│       └── product_category_name_translation.csv # Note: This file is currently ignored as its naming convention does not align with the olist_ prefix used for automatic loading.
│
├── models/                     # Dedicated directory for storing trained machine learning models and data transformers (e.g., scalers).
│
├── requirements.txt            # Lists all Python dependencies and their versions required to run the project.
│
└── README.md                   # This document, providing a comprehensive overview and guide for the project.







